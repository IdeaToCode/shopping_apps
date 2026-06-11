import 'package:flutter/material.dart';
import 'package:shopping_apps/screens/cartScreen.dart';
import 'package:shopping_apps/screens/favoritesScreen.dart';
import 'package:shopping_apps/screens/productsScreen.dart';
import 'package:shopping_apps/screens/profileScreen.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const CustomBottomNavBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey.shade500,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        showUnselectedLabels: true,
        elevation: 0,
        backgroundColor: Colors.white,
        onTap: (index) {
          if (index == selectedIndex) return;

          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>  ProductsScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>  FavoritesScreen()),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: "الرئيسية",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined), // تغيير من grid_view إلى shopping_cart
            activeIcon: Icon(Icons.shopping_cart),
            label: "السلة", // تغيير من "الكرت" إلى "السلة"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            activeIcon: Icon(Icons.favorite), // تصحيح active icon
            label: "المفضل",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            activeIcon: Icon(Icons.account_circle),
            label: "الملف الشخصي", // تغيير من "البوفايل"
          ),
        ],
      ),
    );
  }
}