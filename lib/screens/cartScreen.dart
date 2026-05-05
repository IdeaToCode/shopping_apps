import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_apps/custom_bottom_nav_bar.dart';
import 'package:shopping_apps/screens/favorites_provider.dart';
import 'package:shopping_apps/screens/my_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const screenRoute = '/cartScreen';
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoritesProvider>(context);
    final carditme = provider.cartItems;

    return Scaffold(
      appBar: AppBar(title: const Text("سلة المشتريات"), centerTitle: true),
      body: provider.cartItems.isEmpty
          ? const Center(child: Text("السلة فارغة حالياً"))
          : Column(
              children: [
                Expanded(child: shoppingCardFather(context, carditme)),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 10),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "إجمالي السعر:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${provider.totalPrice}\$",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {},
                        child: const Text(
                          "إتمام الشراء",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 1),
    );
  }
}
