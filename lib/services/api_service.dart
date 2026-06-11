import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  // API端点 - باستخدام FakeStoreAPI (مجاني وموثوق)
  static const String baseUrl = 'https://fakestoreapi.com';

  // جلب جميع المنتجات
  static Future<List<Product>> fetchProducts() async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/products'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Product> products = data
            .map((json) => Product.fromJson(json))
            .toList();
        return products;
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // جلب منتج واحد بالمعرف
  static Future<Product> fetchProductById(int id) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/products/$id'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return Product.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // جلب المنتجات حسب الفئة
  static Future<List<Product>> fetchProductsByCategory(String category) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/products/category/$category'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products by category');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // جلب جميع الفئات المتاحة
  static Future<List<String>> fetchCategories() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/products/categories'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((e) => e.toString()).toList();
      } else {
        return [
          'electronics',
          'jewelery',
          "men's clothing",
          "women's clothing",
        ];
      }
    } catch (e) {
      return ['electronics', 'jewelery', "men's clothing", "women's clothing"];
    }
  }
}
