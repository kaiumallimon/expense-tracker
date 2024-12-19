import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String location,
  }) async {
    try {
      // Create a user with email and password
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      if (user == null) {
        // Handle case where user is unexpectedly null
        return {
          'status': false,
          'message': 'User registration failed. Please try again.',
        };
      }

      // Save user details to Firestore
      final userRef = _firestore.collection('users').doc(user.uid);

      await userRef.set({
        'name': name,
        'email': email,
        'phone': phone,
        'location': location,
        'createdAt': FieldValue.serverTimestamp(), 
      });

      return {
        'status': true,
        'message': 'User registered successfully.',
      };
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication-specific errors
      return {
        'status': false,
        'message': _getFirebaseAuthErrorMessage(e),
      };
    } catch (e) {
      // Handle any other unexpected errors
      return {
        'status': false,
        'message': 'An unexpected error occurred. Please try again.',
      };
    }
  }

  // Helper method to map FirebaseAuthException codes to user-friendly messages
  String _getFirebaseAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email is already in use. Please use a different email.';
      case 'weak-password':
        return 'The password provided is too weak. Please use a stronger password.';
      case 'invalid-email':
        return 'The email address is invalid. Please check and try again.';
      default:
        return e.message ?? 'An unknown error occurred.';
    }
  }
}
