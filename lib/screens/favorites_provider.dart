import 'package:flutter/material.dart';
import 'package:shopping_apps/list_product.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Product> _favoriteItems = [];

  List<Product> get favoriteItems => _favoriteItems;

  bool isExist(Product item) {
    return _favoriteItems.contains(item);
  }

  void toggleFavorite(Product item) {
    if (_favoriteItems.contains(item)) {
      _favoriteItems.remove(item);
    } else {
      _favoriteItems.add(item);
    }

    notifyListeners();
  }

  final List<Product> _cartItems = [];
  bool isExistshop(Product item) {
    return _cartItems.contains(item);
  }

  List<Product> get cartItems => _cartItems;
  void toggleCart(Product item) {
    if (cartItems.contains(item)) {
      cartItems.remove(item);
    } else {
      cartItems.add(item);
    }

    notifyListeners();
  }

  double get totalPrice {
    return _cartItems.fold(0, (sum, item) {
      double price = double.parse(item.price.replaceAll('\$', ''));
      return sum + price;
    });
  }
}
