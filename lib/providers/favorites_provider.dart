import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/local_storage_service.dart';

class FavoritesProvider extends ChangeNotifier {
  List<Product> _favoriteItems = [];
  List<Product> _cartItems = [];

  List<Product> get favoriteItems => _favoriteItems;
  List<Product> get cartItems => _cartItems;

  FavoritesProvider() {
    _loadSavedData();
  }

  // تحميل البيانات المحفوظة عند بدء التشغيل
  Future<void> _loadSavedData() async {
    _favoriteItems = await LocalStorageService.loadFavorites();
    _cartItems = await LocalStorageService.loadCart();
    debugPrint('📦 Loaded favorites: ${_favoriteItems.length} items');
    debugPrint('🛒 Loaded cart: ${_cartItems.length} items');
    notifyListeners();
  }

  // التحقق من وجود في المفضلة (باستخدام id)
  bool isExist(Product item) {
    bool exists = _favoriteItems.any((element) => element.id == item.id);
    return exists;
  }

  // إضافة/إزالة من المفضلة
  Future<void> toggleFavorite(Product item) async {
    debugPrint('❤️ Toggle favorite: ${item.name}, id: ${item.id}');

    // البحث بالـ id بدلاً من المقارنة المباشرة
    final index = _favoriteItems.indexWhere((element) => element.id == item.id);

    if (index != -1) {
      _favoriteItems.removeAt(index);
      debugPrint('❌ Removed from favorites: ${item.name}');
    } else {
      _favoriteItems.add(item);
      debugPrint('✅ Added to favorites: ${item.name}');
    }

    await LocalStorageService.saveFavorites(_favoriteItems);
    notifyListeners();
  }

  // التحقق من وجود في السلة (باستخدام id)
  bool isExistshop(Product item) {
    bool exists = _cartItems.any((element) => element.id == item.id);
    return exists;
  }

  // إضافة/إزالة من السلة - الإصدار المصحح
  Future<void> toggleCart(Product item) async {
    debugPrint('🛒 Toggle cart START: ${item.name}, id: ${item.id}');
    debugPrint('🛒 Current cart items count: ${_cartItems.length}');

    // البحث بالـ id بدلاً من المقارنة المباشرة
    final index = _cartItems.indexWhere((element) => element.id == item.id);

    if (index != -1) {
      _cartItems.removeAt(index);
      debugPrint('❌ Removed from cart: ${item.name}');
    } else {
      _cartItems.add(item);
      debugPrint('✅ Added to cart: ${item.name}');
    }

    debugPrint('🛒 New cart items count: ${_cartItems.length}');
    debugPrint(
      '🛒 Cart items names: ${_cartItems.map((p) => p.name).toList()}',
    );

    // حفظ التغييرات
    await LocalStorageService.saveCart(_cartItems);
    notifyListeners();
  }

  // حذف من السلة
  Future<void> removeFromCart(Product item) async {
    debugPrint('🗑️ Remove from cart: ${item.name}');
    _cartItems.removeWhere((element) => element.id == item.id);
    await LocalStorageService.saveCart(_cartItems);
    notifyListeners();
  }

  // حساب المجموع الكلي
  double get totalPrice {
    return _cartItems.fold(0, (sum, item) => sum + item.price);
  }

  // تنظيف السلة بعد الشراء
  Future<void> clearCart() async {
    debugPrint('🧹 Clearing cart');
    _cartItems.clear();
    await LocalStorageService.saveCart(_cartItems);
    notifyListeners();
  }

  // إعادة تحميل البيانات
  Future<void> reloadData() async {
    debugPrint('🔄 Reloading data');
    await _loadSavedData();
  }
}
