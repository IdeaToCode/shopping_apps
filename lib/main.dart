import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_apps/models/product_model.dart';
import 'package:shopping_apps/screens/pategoryPage.dart';
import 'providers/favorites_provider.dart';
import 'providers/product_provider.dart';
import 'screens/productsScreen.dart';
import 'screens/cartScreen.dart';
import 'screens/favoritesScreen.dart';

import 'screens/profileScreen.dart';
import 'screens/product_details_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale('ar', 'AE'),
        supportedLocales: const [Locale('ar', 'AE'), Locale('en', 'US')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routes: {
          '/': (ctx) => ProductsScreen(),
          ProductsScreen.screenRoute: (context) => ProductsScreen(),
          FavoritesScreen.screenRoute: (context) => FavoritesScreen(),
          CartScreen.screenRoute: (context) => const CartScreen(),
          CategoryPage.screenRoute: (context) =>
              const CategoryPage(categoryName: ''),
          ProfileScreen.screenRoute: (context) => const ProfileScreen(),
          ProductDetailsScreen.screenRoute: (context) => ProductDetailsScreen(
            product: Product(
              id: 0,
              name: '',
              price: 0,
              imageUrl: '',
              description: '',
              category: '',
            ),
          ),
        },
      ),
    );
  }
}
