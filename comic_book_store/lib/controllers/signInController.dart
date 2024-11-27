import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in user
  Future<String?> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      // Sign in with Firebase Authentication
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Success
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors
      return _getErrorMessage(e);
    } catch (e) {
      return 'An error occurred. Please try again.';
    }
  }

  // Firebase Authentication error messages
  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'invalid-email':
        return 'The email address is not valid.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}
