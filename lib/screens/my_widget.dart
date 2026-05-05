import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_apps/list_product.dart';
import 'package:shopping_apps/screens/favorites_provider.dart';
import 'package:shopping_apps/screens/pategoryPage.dart';

Widget shoppingCardFather(BuildContext context, List<Product> cardList) {
  return card(context, cardList, Axis.vertical, 1, true);
}

Widget shoppingCard(BuildContext context, String category) {
  final List<Product> filteredList = allProducts
      .where((p) => p.category == category)
      .toList();
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
                category,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
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
          child: card(context, filteredList, Axis.horizontal, 1, false),
        ),
      ],
    ),
  );
}

Widget card(
  BuildContext context,
  List<Product> filteredList,
  scrollDirection,
  int acro,
  bool vale,
) {
  final provider = Provider.of<FavoritesProvider>(context);
  return SizedBox(
    height: vale ? 300 : 250,
    child: GridView.builder(
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

        return Container(
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
                              provider.isExist(item)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: provider.isExist(item)
                                  ? Colors.red
                                  : Colors.grey,
                              size: 20,
                            ),
                            onPressed: () => provider.toggleFavorite(item),
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
                              provider.isExistshop(item)
                                  ? Icons.add_shopping_cart
                                  : Icons.add_shopping_cart_outlined,
                              color: provider.isExistshop(item)
                                  ? Colors.blue
                                  : Colors.grey,
                              size: 20,
                            ),

                            onPressed: () {
                              provider.toggleCart(item);
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
                          "\$${item.price}",
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
        );
      },
    ),
  );
}
