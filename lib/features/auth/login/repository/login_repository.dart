import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      // Sign in the user with email and password
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      if (user == null) {
        return {
          'error': 'User is null after login. Please try again.',
        };
      }

      // Fetch the user's document from Firestore
      final DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        return {
          'error': 'No user data found with the provided credentials.',
        };
      }

      final Map<String, dynamic>? userData =
          userDoc.data() as Map<String, dynamic>?;

      if (userData == null) {
        return {
          'error': 'Empty user data found with the provided credentials.',
        };
      }

      return {
        'user': user,
        'userData': userData,
      };
    } catch (e) {
      if (e is FirebaseAuthException) {
        return {
          'error': e.message ?? 'An unknown authentication error occurred.',
        };
      }

      return {
        'error': 'An unexpected error occurred: ${e.toString()}',
      };
    }
  }



  Future<bool> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }
}
