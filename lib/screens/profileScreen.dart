import 'package:flutter/material.dart';
import 'package:shopping_apps/custom_bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  static const screenRoute = '/ProfileScreen';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("الملف الشخصي"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.blue,
                    child: CircleAvatar(
                      radius: 56,
                      backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150',
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "محمد",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Software Engineering Student",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem("Projects", "12"),
                  _buildStatItem("Skill", "Flutter"),
                  _buildStatItem("Rank", "Top"),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _buildProfileOption(
                      Icons.person_outline,
                      "تعديل البيانات",
                      () {},
                    ),
                    _buildProfileOption(
                      Icons.favorite_border,
                      "المفضلات",
                      () {},
                    ),
                    _buildProfileOption(
                      Icons.shopping_bag_outlined,
                      "طلباتي",
                      () {},
                    ),
                    _buildProfileOption(Icons.language, "اللغة", () {}),
                    const Divider(height: 1),
                    _buildProfileOption(
                      Icons.logout,
                      "تسجيل الخروج",
                      () {},
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 3),
    );
  }

  Widget _buildProfileOption(
    IconData icon,
    String title,
    VoidCallback onTap, {
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.blue),
      title: Text(title, style: TextStyle(color: color)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
