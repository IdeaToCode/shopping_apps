import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';

class FirebaseService {
  static FirebaseAuth get _auth {
    try {
      return FirebaseAuth.instance;
    } catch (e) {
      debugPrint('❌ FirebaseAuth not initialized: $e');
      rethrow;
    }
  }

  static FirebaseFirestore get _firestore {
    try {
      return FirebaseFirestore.instance;
    } catch (e) {
      debugPrint('❌ Firestore not initialized: $e');
      rethrow;
    }
  }

  // Collections
  static const String PRODUCTS_COLLECTION = 'products';
  static const String USERS_COLLECTION = 'users';

  // Stream of user authentication state
  static Stream<User?> get authStateChanges {
    try {
      return _auth.authStateChanges();
    } catch (e) {
      debugPrint('❌ Error getting authStateChanges: $e');
      return Stream.value(null);
    }
  }

  // Get current user
  static User? get currentUser {
    try {
      return _auth.currentUser;
    } catch (e) {
      debugPrint('❌ Error getting currentUser: $e');
      return null;
    }
  }

  // Check if user is logged in
  static bool get isLoggedIn => currentUser != null;

  // Get current user ID
  static String? get currentUserId => currentUser?.uid;

  // Sign up with email and password
  static Future<UserCredential> signUpWithEmail(
    String email,
    String password,
    String name,
  ) async {
    try {
      debugPrint('🔐 Creating user: $email');

      // Create user
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password,
          );

      debugPrint('✅ User created: ${userCredential.user?.uid}');

      // Save user data to Firestore
      if (userCredential.user != null) {
        debugPrint('💾 Saving user data to Firestore...');
        await _firestore
            .collection(USERS_COLLECTION)
            .doc(userCredential.user!.uid)
            .set({
              'uid': userCredential.user!.uid,
              'email': email.trim(),
              'name': name,
              'createdAt': FieldValue.serverTimestamp(),
            });

        // Update display name
        await userCredential.user!.updateDisplayName(name);
        debugPrint('✅ User data saved successfully');
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      debugPrint('❌ FirebaseAuthException: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('حدث خطأ: $e');
    }
  }

  // Sign in with email and password
  static Future<UserCredential> signInWithEmail(
    String email,
    String password,
  ) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      debugPrint('❌ FirebaseAuthException: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('حدث خطأ: $e');
    }
  }

  // Sign out
  static Future<void> signOut() async {
    await _auth.signOut();
  }

  // ============ Products ============

  // Get all products stream (real-time)
  static Stream<List<Product>> getProductsStream() {
    try {
      return _firestore.collection(PRODUCTS_COLLECTION).snapshots().map((
        snapshot,
      ) {
        return snapshot.docs.map((doc) {
          return Product.fromFirestore(doc);
        }).toList();
      });
    } catch (e) {
      debugPrint('❌ Error getting products stream: $e');
      return Stream.value([]);
    }
  }

  // ============ Favorites ============

  // Get favorites stream for current user
  static Stream<List<Product>> getFavoritesStream() {
    if (currentUserId == null) return Stream.value([]);

    try {
      return _firestore
          .collection(USERS_COLLECTION)
          .doc(currentUserId)
          .collection('favorites')
          .snapshots()
          .map((snapshot) {
            return snapshot.docs.map((doc) {
              return Product.fromFirestore(doc);
            }).toList();
          });
    } catch (e) {
      debugPrint('❌ Error getting favorites stream: $e');
      return Stream.value([]);
    }
  }

  // Toggle favorite
  static Future<bool> toggleFavorite(Product product) async {
    if (currentUserId == null) throw Exception('User not logged in');

    final docRef = _firestore
        .collection(USERS_COLLECTION)
        .doc(currentUserId)
        .collection('favorites')
        .doc(product.id.toString());

    final doc = await docRef.get();

    if (doc.exists) {
      await docRef.delete();
      return false;
    } else {
      await docRef.set(product.toMap());
      return true;
    }
  }

  // ============ Cart ============

  // Get cart stream for current user
  static Stream<List<Product>> getCartStream() {
    if (currentUserId == null) return Stream.value([]);

    try {
      return _firestore
          .collection(USERS_COLLECTION)
          .doc(currentUserId)
          .collection('cart')
          .snapshots()
          .map((snapshot) {
            return snapshot.docs.map((doc) {
              return Product.fromFirestore(doc);
            }).toList();
          });
    } catch (e) {
      debugPrint('❌ Error getting cart stream: $e');
      return Stream.value([]);
    }
  }

  // Add to cart
  static Future<void> addToCart(Product product) async {
    if (currentUserId == null) throw Exception('User not logged in');

    await _firestore
        .collection(USERS_COLLECTION)
        .doc(currentUserId)
        .collection('cart')
        .doc(product.id.toString())
        .set(product.toMap());
  }

  // Remove from cart
  static Future<void> removeFromCart(String productId) async {
    if (currentUserId == null) throw Exception('User not logged in');

    await _firestore
        .collection(USERS_COLLECTION)
        .doc(currentUserId)
        .collection('cart')
        .doc(productId)
        .delete();
  }

  // Clear cart
  static Future<void> clearCart() async {
    if (currentUserId == null) return;

    final batch = _firestore.batch();
    final snapshot = await _firestore
        .collection(USERS_COLLECTION)
        .doc(currentUserId)
        .collection('cart')
        .get();

    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }
}
