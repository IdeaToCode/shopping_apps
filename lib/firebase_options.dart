// lib/firebase_options.dart
import 'package:flutter/material.dart';

class FirebaseConfig {
  // إعدادات Firebase للويب
  static const String webApiKey = 'AIzaSyBas2ypruRKf_KZ6h7zRdEkjFsbC7IM_SU';
  static const String webAuthDomain = 'shoppingapps-5a979.firebaseapp.com';
  static const String webProjectId = 'shoppingapps-5a979';
  static const String webStorageBucket =
      'shoppingapps-5a979.firebasestorage.app';
  static const String webMessagingSenderId = '612445465517';
  static const String webAppId = '1:612445465517:web:5501acf46ec41145d9cf24';

  // إعدادات Firebase للأندرويد (نفس المشروع)
  static const String androidApiKey = 'AIzaSyBas2ypruRKf_KZ6h7zRdEkjFsbC7IM_SU';
  static const String androidAppId =
      '1:612445465517:android:5501acf46ec41145d9cf24';
  static const String androidMessagingSenderId = '612445465517';
  static const String androidProjectId = 'shoppingapps-5a979';
}
