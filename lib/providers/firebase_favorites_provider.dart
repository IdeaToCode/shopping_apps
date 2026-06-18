import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/firebase_service.dart';

class FirebaseFavoritesProvider extends ChangeNotifier {
  List<Product> _favoriteItems = [];
  List<Product> _cartItems = [];
  bool _isLoading = true;

  List<Product> get favoriteItems => _favoriteItems;
  List<Product> get cartItems => _cartItems;
  bool get isLoading => _isLoading;

  FirebaseFavoritesProvider() {
    _listenToFavorites();
    _listenToCart();
  }

  void _listenToFavorites() {
    FirebaseService.getFavoritesStream().listen((favorites) {
      _favoriteItems = favorites;
      _isLoading = false;
      notifyListeners();
    });
  }

  void _listenToCart() {
    FirebaseService.getCartStream().listen((cart) {
      _cartItems = cart;
      notifyListeners();
    });
  }

  bool isExist(Product item) {
    return _favoriteItems.any((element) => element.id == item.id);
  }

  Future<void> toggleFavorite(Product item) async {
    try {
      await FirebaseService.toggleFavorite(item);
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
      rethrow;
    }
  }

  bool isExistshop(Product item) {
    return _cartItems.any((element) => element.id == item.id);
  }

  Future<void> toggleCart(Product item) async {
    try {
      if (isExistshop(item)) {
        await FirebaseService.removeFromCart(item.id.toString());
      } else {
        await FirebaseService.addToCart(item);
      }
    } catch (e) {
      debugPrint('Error toggling cart: $e');
      rethrow;
    }
  }

  Future<void> removeFromCart(Product item) async {
    try {
      await FirebaseService.removeFromCart(item.id.toString());
    } catch (e) {
      debugPrint('Error removing from cart: $e');
      rethrow;
    }
  }

  double get totalPrice {
    return _cartItems.fold(0, (sum, item) => sum + item.price);
  }

  Future<void> clearCart() async {
    try {
      await FirebaseService.clearCart();
    } catch (e) {
      debugPrint('Error clearing cart: $e');
      rethrow;
    }
  }
}
