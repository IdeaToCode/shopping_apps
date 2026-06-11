import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_apps/providers/favorites_provider.dart';
import 'package:shopping_apps/screens/product_details_screen.dart';
import '../custom_bottom_nav_bar.dart';
import '../providers/product_provider.dart';
import '../models/product_model.dart';

class CategoryPage extends StatelessWidget {
  static const screenRoute = '/categoryPage';
  final String categoryName;

  const CategoryPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    // تصفية المنتجات حسب الفئة
    final List<Product> filteredProducts = productProvider.originalProducts
        .where((p) => p.category == categoryName)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(_getCategoryNameInArabic(categoryName)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: productProvider.isLoading && filteredProducts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : filteredProducts.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.category_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text("لا توجد منتجات في هذه الفئة حالياً"),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return _buildCategoryProductCard(context, product);
              },
            ),
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),
    );
  }

  Widget _buildCategoryProductCard(BuildContext context, Product product) {
    final favoritesProvider = Provider.of<FavoritesProvider>(
      context,
      listen: false,
    );

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.broken_image),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.9),
                        radius: 18,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            favoritesProvider.isExist(product)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: favoritesProvider.isExist(product)
                                ? Colors.red
                                : Colors.grey,
                            size: 18,
                          ),
                          onPressed: () =>
                              favoritesProvider.toggleFavorite(product),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة مساعدة لتحويل أسماء الفئات إلى العربية
  String _getCategoryNameInArabic(String category) {
    switch (category.toLowerCase()) {
      case 'electronics':
        return 'إلكترونيات';
      case 'jewelery':
        return 'مجوهرات';
      case "men's clothing":
        return 'ملابس رجالية';
      case "women's clothing":
        return 'ملابس نسائية';
      default:
        return category;
    }
  }
}
