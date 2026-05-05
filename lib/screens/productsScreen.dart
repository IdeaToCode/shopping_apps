import 'package:flutter/material.dart';
import 'package:shopping_apps/custom_bottom_nav_bar.dart';

//import 'package:shopping_apps/screens/favorites_provider.dart';
import 'package:shopping_apps/screens/my_widget.dart';

class ProductsScreen extends StatelessWidget {
  static const screenRoute = '/productsScreen';
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<FavoritesProvider>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,

        body: ListView(
          children: [
            shoppingCard(context, 'ملابس'),
            shoppingCard(context, 'إلكترونيات'),
            shoppingCard(context, 'منزل'),
          ],
        ),
        bottomNavigationBar: CustomBottomNavBar(selectedIndex: 0),
      ),
    );
  }
}
