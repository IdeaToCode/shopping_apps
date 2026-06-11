import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = false;
  bool _isOffline = false;
  String? _errorMessage;

  List<Product> get allProducts =>
      _filteredProducts.isEmpty ? _allProducts : _filteredProducts;
  List<Product> get originalProducts => _allProducts;
  bool get isLoading => _isLoading;
  bool get isOffline => _isOffline;
  String? get errorMessage => _errorMessage;

  ProductProvider() {
    loadProducts();
  }

  // تحميل المنتجات مع دعم Offline
  Future<void> loadProducts({String? category}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    // التحقق من الاتصال بالإنترنت
    var connectivityResult = await Connectivity().checkConnectivity();
    bool hasInternet = connectivityResult != ConnectivityResult.none;

    if (hasInternet) {
      // محاولة جلب البيانات من API
      try {
        List<Product> products;
        if (category != null && category.isNotEmpty) {
          products = await ApiService.fetchProductsByCategory(category);
        } else {
          products = await ApiService.fetchProducts();
        }

        _allProducts = products;
        _filteredProducts = [];
        _isOffline = false;

        // حفظ في cache
        await LocalStorageService.cacheProducts(products);
        await LocalStorageService.setOfflineMode(false);

        _errorMessage = null;
      } catch (e) {
        // فشل الاتصال - استخدام البيانات المخزنة
        await _loadFromCache(category);
        _isOffline = true;
        await LocalStorageService.setOfflineMode(true);
        _errorMessage =
            'لا يوجد اتصال بالإنترنت. يتم عرض آخر البيانات المحفوظة.';
      }
    } else {
      // لا يوجد اتصال - استخدام cache
      await _loadFromCache(category);
      _isOffline = true;
      await LocalStorageService.setOfflineMode(true);
      _errorMessage = '⚠️ وضع Offline - يتم عرض بيانات سابقة';
    }

    _isLoading = false;
    notifyListeners();
  }

  // تحميل من cache
  Future<void> _loadFromCache(String? category) async {
    List<Product> cachedProducts =
        await LocalStorageService.loadCachedProducts();

    if (cachedProducts.isNotEmpty) {
      if (category != null && category.isNotEmpty) {
        _allProducts = cachedProducts
            .where((p) => p.category == category)
            .toList();
      } else {
        _allProducts = cachedProducts;
      }
      _filteredProducts = [];
    } else {
      _allProducts = [];
      _errorMessage = 'لا توجد بيانات متاحة. يرجى الاتصال بالإنترنت أول مرة.';
    }
  }

  // البحث عن منتج بالاسم
  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = [];
    } else {
      _filteredProducts = _allProducts.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  // تحديث المنتجات يدوياً
  Future<void> refreshProducts() async {
    await loadProducts();
  }

  // الحصول على منتج بالمعرف
  Product? getProductById(int id) {
    try {
      return _allProducts.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  // الحصول على فئات فريدة
  List<String> getUniqueCategories() {
    Set<String> categories = {};
    for (var product in _allProducts) {
      categories.add(product.category);
    }
    return categories.toList();
  }
}
