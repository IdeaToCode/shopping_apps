import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/firebase_service.dart';

class FirebaseProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = true;
  String? _errorMessage;

  List<Product> get products =>
      _filteredProducts.isEmpty ? _products : _filteredProducts;
  List<Product> get allProducts => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  FirebaseProductProvider() {
    _listenToProducts();
  }

  void _listenToProducts() {
    FirebaseService.getProductsStream().listen(
      (products) {
        _products = products;
        _filteredProducts = [];
        _isLoading = false;
        _errorMessage = null;
        notifyListeners();
      },
      onError: (error) {
        _isLoading = false;
        _errorMessage = error.toString();
        notifyListeners();
      },
    );
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = [];
    } else {
      _filteredProducts = _products.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  Product? getProductById(int id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  List<String> getUniqueCategories() {
    Set<String> categories = {};
    for (var product in _products) {
      categories.add(product.category);
    }
    return categories.toList();
  }
}
