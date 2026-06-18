import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_apps/screens/pategoryPage.dart';
import '../models/product_model.dart';
import '../providers/favorites_provider.dart';
import '../providers/product_provider.dart';

import 'product_details_screen.dart';

// دالة عرض السلة (تستخدم في CartScreen)
Widget shoppingCardFather(BuildContext context, List<Product> cardList) {
  return _buildCartList(context, cardList);
}

// دالة عرض المنتجات حسب الفئة (تستخدم في ProductsScreen)
Widget shoppingCard(BuildContext context, String category) {
  final productProvider = Provider.of<ProductProvider>(context);

  // تصفية المنتجات حسب الفئة من ProductProvider (المصدر الحقيقي)
  final List<Product> filteredList = productProvider.originalProducts
      .where((p) => p.category == category)
      .toList();

  if (filteredList.isEmpty) return const SizedBox.shrink();

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getCategoryNameInArabic(category),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CategoryPage(categoryName: category),
                    ),
                  );
                },
                child: Text(
                  "الكل",
                  style: TextStyle(color: Colors.blue[800], fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 250,
          child: _buildHorizontalProductList(context, filteredList),
        ),
      ],
    ),
  );
}

// دالة عرض قائمة أفقية من المنتجات مع أزرار تعمل بشكل صحيح
Widget _buildHorizontalProductList(
  BuildContext context,
  List<Product> products,
) {
  // استخدام Consumer بدلاً من Provider.of للتحديث التلقائي
  return Consumer<FavoritesProvider>(
    builder: (context, favoritesProvider, child) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];
          return Container(
            width: 180,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsScreen(product: item),
                  ),
                );
              },
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                              item.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) => Container(
                                color: Colors.grey[200],
                                child: const Icon(Icons.broken_image),
                              ),
                            ),
                          ),
                          // زر المفضلة
                          Positioned(
                            top: 10,
                            right: 10,
                            child: CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.9),
                              radius: 18,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  favoritesProvider.isExist(item)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: favoritesProvider.isExist(item)
                                      ? Colors.red
                                      : Colors.grey,
                                  size: 20,
                                ),
                                onPressed: () async {
                                  debugPrint(
                                    '❤️ Favorite pressed (horizontal): ${item.name}',
                                  );
                                  await favoritesProvider.toggleFavorite(item);
                                  // إظهار رسالة تأكيد
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          favoritesProvider.isExist(item)
                                              ? '✅ تم إضافة ${item.name} إلى المفضلة'
                                              : '❌ تم إزالة ${item.name} من المفضلة',
                                        ),
                                        duration: const Duration(seconds: 1),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          // زر السلة
                          Positioned(
                            top: 10,
                            left: 10,
                            child: CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.9),
                              radius: 18,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  favoritesProvider.isExistshop(item)
                                      ? Icons.shopping_cart
                                      : Icons.shopping_cart_outlined,
                                  color: favoritesProvider.isExistshop(item)
                                      ? Colors.blue
                                      : Colors.grey,
                                  size: 20,
                                ),
                                onPressed: () async {
                                  debugPrint(
                                    '🛒 Cart pressed (horizontal): ${item.name}',
                                  );
                                  await favoritesProvider.toggleCart(item);
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          favoritesProvider.isExistshop(item)
                                              ? '✅ تم إضافة ${item.name} إلى السلة'
                                              : '❌ تم إزالة ${item.name} من السلة',
                                        ),
                                        duration: const Duration(seconds: 1),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "\$${item.price.toStringAsFixed(2)}",
                              style: TextStyle(
                                color: Colors.blue[900],
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

// دالة عرض قائمة عمودية للسلة
Widget _buildCartList(BuildContext context, List<Product> cartList) {
  return Consumer<FavoritesProvider>(
    builder: (context, favoritesProvider, child) {
      return ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: cartList.length,
        itemBuilder: (context, index) {
          final item = cartList[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.network(
                        item.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.broken_image),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getCategoryNameInArabic(item.category),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "\$${item.price.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => favoritesProvider.removeFromCart(item),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
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
    case 'ملابس':
      return 'ملابس';
    case 'منزل':
      return 'منزل';
    default:
      return category;
  }
}

Widget card(
  BuildContext context,
  List<Product> filteredList,
  scrollDirection,
  int acro,
  bool vale,
) {
  if (scrollDirection == Axis.horizontal) {
    return _buildHorizontalProductList(context, filteredList);
  }

  return Consumer<FavoritesProvider>(
    builder: (context, favoritesProvider, child) {
      return GridView.builder(
        scrollDirection: scrollDirection,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: acro,
          childAspectRatio: 1.3,
          mainAxisSpacing: 15,
        ),
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final item = filteredList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(product: item),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                              item.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) => Container(
                                color: Colors.grey[200],
                                child: const Icon(Icons.broken_image),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.9),
                              radius: 18,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  favoritesProvider.isExist(item)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: favoritesProvider.isExist(item)
                                      ? Colors.red
                                      : Colors.grey,
                                  size: 20,
                                ),
                                onPressed: () async {
                                  await favoritesProvider.toggleFavorite(item);
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          favoritesProvider.isExist(item)
                                              ? '✅ تم الإضافة إلى المفضلة'
                                              : '❌ تم الإزالة من المفضلة',
                                        ),
                                        duration: const Duration(seconds: 1),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.9),
                              radius: 18,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  favoritesProvider.isExistshop(item)
                                      ? Icons.shopping_cart
                                      : Icons.shopping_cart_outlined,
                                  color: favoritesProvider.isExistshop(item)
                                      ? Colors.blue
                                      : Colors.grey,
                                  size: 20,
                                ),
                                onPressed: () async {
                                  await favoritesProvider.toggleCart(item);
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          favoritesProvider.isExistshop(item)
                                              ? '✅ تم الإضافة إلى السلة'
                                              : '❌ تم الإزالة من السلة',
                                        ),
                                        duration: const Duration(seconds: 1),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (vale)
                              Text(
                                item.description,
                                style: const TextStyle(fontSize: 14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            Text(
                              "\$${item.price.toStringAsFixed(2)}",
                              style: TextStyle(
                                color: Colors.blue[900],
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
