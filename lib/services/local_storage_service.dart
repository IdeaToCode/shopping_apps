import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model.dart';

class LocalStorageService {
  static const String PRODUCTS_CACHE_KEY = 'cached_products';
  static const String FAVORITES_KEY = 'favorites';
  static const String CART_KEY = 'cart';
  static const String LAST_UPDATE_KEY = 'last_update';
  static const String OFFLINE_MODE_KEY = 'offline_mode';

  // التحقق مما إذا كنا على منصة الويب
  static bool get isWeb => identical(0, 0.0) ? true : false;

  // ============ منتجات ============

  // حفظ المنتجات في cache
  static Future<void> cacheProducts(List<Product> products) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<Map<String, dynamic>> productsJson = products
          .map((p) => p.toJson())
          .toList();
      await prefs.setString(PRODUCTS_CACHE_KEY, json.encode(productsJson));
      await prefs.setString(LAST_UPDATE_KEY, DateTime.now().toIso8601String());
      debugPrint('✅ Products cached (${products.length} items)');
    } catch (e) {
      debugPrint('Error caching products: $e');
    }
  }

  // تحميل المنتجات من cache
  static Future<List<Product>> loadCachedProducts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? data = prefs.getString(PRODUCTS_CACHE_KEY);
      if (data != null) {
        List<dynamic> jsonData = json.decode(data);
        debugPrint('✅ Loaded cached products: ${jsonData.length} items');
        return jsonData.map((json) => Product.fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint('Error loading cached products: $e');
    }
    return [];
  }

  // ============ المفضلات ============

  // حفظ المفضلات
  static Future<void> saveFavorites(List<Product> favorites) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<Map<String, dynamic>> favoritesJson = favorites
          .map((p) => p.toJson())
          .toList();
      await prefs.setString(FAVORITES_KEY, json.encode(favoritesJson));
      debugPrint('✅ Favorites saved: ${favorites.length} items');
    } catch (e) {
      debugPrint('Error saving favorites: $e');
    }
  }

  // تحميل المفضلات
  static Future<List<Product>> loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? data = prefs.getString(FAVORITES_KEY);
      if (data != null) {
        List<dynamic> jsonData = json.decode(data);
        debugPrint('✅ Favorites loaded: ${jsonData.length} items');
        return jsonData.map((json) => Product.fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint('Error loading favorites: $e');
    }
    return [];
  }

  // ============ السلة ============

  // حفظ السلة
  static Future<void> saveCart(List<Product> cart) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<Map<String, dynamic>> cartJson = cart
          .map((p) => p.toJson())
          .toList();
      await prefs.setString(CART_KEY, json.encode(cartJson));
      debugPrint('✅ Cart saved: ${cart.length} items');
    } catch (e) {
      debugPrint('Error saving cart: $e');
    }
  }

  // تحميل السلة
  static Future<List<Product>> loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? data = prefs.getString(CART_KEY);
      if (data != null) {
        List<dynamic> jsonData = json.decode(data);
        debugPrint('✅ Cart loaded: ${jsonData.length} items');
        return jsonData.map((json) => Product.fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint('Error loading cart: $e');
    }
    return [];
  }

  // ============ أدوات مساعدة ============

  static Future<DateTime?> getLastUpdateTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? lastUpdate = prefs.getString(LAST_UPDATE_KEY);
      if (lastUpdate != null) {
        return DateTime.parse(lastUpdate);
      }
    } catch (e) {
      debugPrint('Error getting last update time: $e');
    }
    return null;
  }

  static Future<void> setOfflineMode(bool isOffline) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(OFFLINE_MODE_KEY, isOffline);
    } catch (e) {
      debugPrint('Error setting offline mode: $e');
    }
  }

  static Future<bool> getOfflineMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(OFFLINE_MODE_KEY) ?? false;
    } catch (e) {
      return false;
    }
  }
}
