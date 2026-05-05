import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_apps/screens/cartScreen.dart';
import 'package:shopping_apps/screens/favoritesScreen.dart';
import 'package:shopping_apps/screens/favorites_provider.dart';
import 'package:shopping_apps/screens/pategoryPage.dart';
import 'package:shopping_apps/screens/productsScreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shopping_apps/screens/profileScreen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritesProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // تحديد اللغة والاتجاه
      locale: const Locale('ar', 'AE'), // 'ar' للعربية
      supportedLocales: const [Locale('ar', 'AE'), Locale('en', 'US')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // home: ProductsScreen(),
      // initialRoute: '/',
      routes: {
        '/': (ctx) => ProductsScreen(),
        ProductsScreen.screenRoute: (context) => ProductsScreen(),
        FavoritesScreen.screenRoute: (context) => FavoritesScreen(),
        CartScreen.screenRoute: (context) => CartScreen(),
        CategoryPage.screenRoute: (context) => CategoryPage(categoryName: ''),
        ProfileScreen.screenRoute: (context) => ProfileScreen(),
      },
    );
  }
}
