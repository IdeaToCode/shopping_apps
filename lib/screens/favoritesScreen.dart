import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_apps/custom_bottom_nav_bar.dart';
import 'package:shopping_apps/screens/favorites_provider.dart';
import 'package:shopping_apps/screens/my_widget.dart';

class FavoritesScreen extends StatelessWidget {
  static const screenRoute = '/favoritesScreen';
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoritesProvider>(context);
    final favoriteItems = provider.favoriteItems;

    return Scaffold(
      appBar: AppBar(title: const Text("المفضلات")),

      body: card(context, favoriteItems, Axis.vertical, 1, true),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 2),
    );
  }
}
