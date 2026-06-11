import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../custom_bottom_nav_bar.dart';
import '../providers/product_provider.dart';
import '../providers/favorites_provider.dart';
import '../models/product_model.dart';
import 'product_details_screen.dart';
import 'my_widget.dart';

class ProductsScreen extends StatelessWidget {
  static const screenRoute = '/productsScreen';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: const ProductsScreenContent(),
    );
  }
}

class ProductsScreenContent extends StatefulWidget {
  const ProductsScreenContent({super.key});

  @override
  State<ProductsScreenContent> createState() => _ProductsScreenContentState();
}

class _ProductsScreenContentState extends State<ProductsScreenContent> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    context.read<ProductProvider>().searchProducts(_searchController.text);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final favoritesProvider = context.watch<FavoritesProvider>();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('متجر الإلكتروني'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'ابحث عن منتج...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
            ),
          ),
        ),
        body: _buildBody(productProvider, favoritesProvider),
        bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),
      ),
    );
  }

  Widget _buildBody(
    ProductProvider productProvider,
    FavoritesProvider favoritesProvider,
  ) {
    if (productProvider.isLoading && productProvider.allProducts.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (productProvider.errorMessage != null &&
        productProvider.allProducts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              productProvider.errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => productProvider.refreshProducts(),
              icon: const Icon(Icons.refresh),
              label: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      );
    }

    if (productProvider.allProducts.isEmpty) {
      return const Center(child: Text('لا توجد منتجات'));
    }

    return Column(
      children: [
        if (productProvider.isOffline)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            color: Colors.orange[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off, size: 18, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  'وضع Offline - يتم عرض بيانات سابقة',
                  style: TextStyle(color: Colors.orange[800]),
                ),
              ],
            ),
          ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: productProvider.allProducts.length,
            itemBuilder: (context, index) {
              final product = productProvider.allProducts[index];
              return _buildProductCard(context, product);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    // استخدام Consumer بدلاً من Provider.of للتحديث التلقائي
    return Consumer<FavoritesProvider>(
      builder: (context, provider, child) {
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
                        // زر المفضلة
                        Positioned(
                          top: 8,
                          right: 8,
                          child: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.9),
                            radius: 18,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                provider.isExist(product)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: provider.isExist(product)
                                    ? Colors.red
                                    : Colors.grey,
                                size: 18,
                              ),
                              onPressed: () async {
                                debugPrint(
                                  '❤️ Favorite pressed: ${product.name}',
                                );
                                await provider.toggleFavorite(product);
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        provider.isExist(product)
                                            ? '✅ تم إضافة ${product.name} إلى المفضلة'
                                            : '❌ تم إزالة ${product.name} من المفضلة',
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
                          top: 8,
                          left: 8,
                          child: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.9),
                            radius: 18,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                provider.isExistshop(product)
                                    ? Icons.shopping_cart
                                    : Icons.shopping_cart_outlined,
                                color: provider.isExistshop(product)
                                    ? Colors.blue
                                    : Colors.grey,
                                size: 18,
                              ),
                              onPressed: () async {
                                debugPrint('🛒 Cart pressed: ${product.name}');
                                debugPrint(
                                  '🛒 Before - Cart items count: ${provider.cartItems.length}',
                                );
                                await provider.toggleCart(product);
                                debugPrint(
                                  '🛒 After - Cart items count: ${provider.cartItems.length}',
                                );
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        provider.isExistshop(product)
                                            ? '✅ تم إضافة ${product.name} إلى السلة'
                                            : '❌ تم إزالة ${product.name} من السلة',
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
      },
    );
  }
}
