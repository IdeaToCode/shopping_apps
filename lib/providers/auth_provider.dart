import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_service.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _user != null;

  AuthProvider() {
    // Listen to auth state changes
    FirebaseService.authStateChanges.listen((User? user) {
      _user = user;
      debugPrint('🔐 Auth state changed: ${user?.email ?? 'No user'}');
      notifyListeners();
    });
  }

  // Sign up
  Future<void> signUp(String email, String password, String name) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      debugPrint('📝 Attempting sign up for: $email');
      await FirebaseService.signUpWithEmail(email, password, name);
      debugPrint('✅ Sign up successful!');
    } on FirebaseAuthException catch (e) {
      debugPrint('❌ Firebase Auth Error: ${e.code} - ${e.message}');
      _errorMessage = _handleAuthError(e);
      rethrow;
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Sign in
  Future<void> signIn(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      debugPrint('📝 Attempting sign in for: $email');
      await FirebaseService.signInWithEmail(email, password);
      debugPrint('✅ Sign in successful!');
    } on FirebaseAuthException catch (e) {
      debugPrint('❌ Firebase Auth Error: ${e.code} - ${e.message}');
      _errorMessage = _handleAuthError(e);
      rethrow;
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Sign out
  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    try {
      await FirebaseService.signOut();
      debugPrint('✅ Sign out successful!');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'هذا البريد الإلكتروني مسجل بالفعل';
      case 'invalid-email':
        return 'البريد الإلكتروني غير صالح';
      case 'weak-password':
        return 'كلمة المرور ضعيفة (يجب أن تكون 6 أحرف على الأقل)';
      case 'user-not-found':
        return 'لا يوجد مستخدم بهذا البريد';
      case 'wrong-password':
        return 'كلمة المرور غير صحيحة';
      case 'too-many-requests':
        return 'طلبات كثيرة جداً. حاول مرة أخرى لاحقاً';
      case 'network-request-failed':
        return 'خطأ في الشبكة. تأكد من اتصالك بالإنترنت';
      default:
        return 'حدث خطأ: ${e.message}';
    }
  }
}
