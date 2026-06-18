import 'package:flutter/material.dart';

import 'auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const screenRoute = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint('🔄 SplashScreen - initState');

    // استخدام WidgetsBinding لضمان اكتمال بناء الـ Widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateToLogin();
    });
  }

  void _navigateToLogin() {
    debugPrint('➡️ محاولة الانتقال إلى LoginScreen');

    if (mounted) {
      // تأخير بسيط لرؤية شاشة Splash
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          debugPrint('✅ الانتقال إلى LoginScreen');
          Navigator.pushReplacementNamed(context, LoginScreen.screenRoute);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('🔄 SplashScreen - build');
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              'جاري تحميل المتجر...',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
