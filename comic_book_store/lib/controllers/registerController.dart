import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comic_book_store/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register user
  Future<String?> registerUser({
    required String fullName,
    required String email,
    required String password,
    required String contactNumber,
  }) async {
    try {
      // Create user with Firebase Authentication
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send email verification
      User? user = userCredential.user;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }

      // Create UserModel and store in Firestore
      final userModel = UserModel(
        uid: user!.uid,
        fullName: fullName,
        email: email,
        contactNumber: contactNumber,
        createdAt: DateTime.now(),
      );

      await _firestore.collection('users').doc(userModel.uid).set(userModel.toMap());

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
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'invalid-email':
        return 'The email address is not valid.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}