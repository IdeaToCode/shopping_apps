import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopping_apps/providers/product_provider.dart';
import 'package:shopping_apps/screens/cartScreen.dart';
import 'package:shopping_apps/screens/favoritesScreen.dart';
import 'package:shopping_apps/screens/pategoryPage.dart';
import 'package:shopping_apps/screens/productsScreen.dart';
import 'package:shopping_apps/screens/profileScreen.dart';
import 'providers/auth_provider.dart';
import 'providers/firebase_favorites_provider.dart';

import 'screens/splash_screen.dart';

import 'screens/product_details_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'models/product_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyBas2ypruRKf_KZ6h7zRdEkjFsbC7lM_SU',
        appId: '1:612445465517:web:5501acf46ec41145d9cf24',
        messagingSenderId: '612445465517',
        projectId: 'shoppingapps-5a979',
        authDomain: 'shoppingapps-5a979.firebaseapp.com',
        storageBucket: 'shoppingapps-5a979.firebasestorage.app',
      ),
    );
    debugPrint('✅ Firebase initialized successfully!');
  } catch (e) {
    debugPrint('❌ Firebase initialization error: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ✅ Auth Provider (Firebase)
        ChangeNotifierProvider(create: (_) => AuthProvider()),

        // ✅ Products from API
        ChangeNotifierProvider(create: (_) => ProductProvider()),

        // ✅ Favorites & Cart from Firestore
        ChangeNotifierProvider(create: (_) => FirebaseFavoritesProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'متجر إلكتروني',
        locale: const Locale('ar', 'AE'),
        supportedLocales: const [Locale('ar', 'AE'), Locale('en', 'US')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        initialRoute: '/splash',
        routes: {
          '/splash': (ctx) => const SplashScreen(),
          '/login': (ctx) => const LoginScreen(),
          '/register': (ctx) => const RegisterScreen(),
          ProductsScreen.screenRoute: (ctx) => const ProductsScreen(),
          FavoritesScreen.screenRoute: (ctx) => FavoritesScreen(),
          CartScreen.screenRoute: (ctx) => const CartScreen(),
          CategoryPage.screenRoute: (ctx) =>
              const CategoryPage(categoryName: ''),

          ProfileScreen.screenRoute: (ctx) => const ProfileScreen(),
          ProductDetailsScreen.screenRoute: (ctx) => ProductDetailsScreen(
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
