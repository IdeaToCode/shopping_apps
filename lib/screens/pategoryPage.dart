import 'package:flutter/material.dart';

import 'package:shopping_apps/custom_bottom_nav_bar.dart';
import 'package:shopping_apps/list_product.dart';

import 'package:shopping_apps/screens/my_widget.dart';

class CategoryPage extends StatelessWidget {
  static const screenRoute = '/categoryPage';
  final String categoryName;

  const CategoryPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final List<Product> filteredProducts = allProducts
        .where((p) => p.category == categoryName)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("قسم $categoryName"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: filteredProducts.isEmpty
          ? const Center(child: Text("لا توجد منتجات في هذه الفئة حالياً"))
          : Container(
              height: double.infinity,
              child: card(context, filteredProducts, Axis.vertical, 1, true),
            ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 3),
    );
  }
}
