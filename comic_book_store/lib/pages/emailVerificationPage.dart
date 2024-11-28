import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:comic_book_store/routes/appRoutes.dart';
import 'package:comic_book_store/constants/colors.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({Key? key}) : super(key: key);

  @override
  _EmailVerificationPageState createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isEmailVerified = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkEmailVerified();
  }

  Future<void> _checkEmailVerified() async {
    User? user = _auth.currentUser;
    await user?.reload();
    setState(() {
      _isEmailVerified = user?.emailVerified ?? false;
    });

    if (_isEmailVerified) {
      Get.offAllNamed(AppRoutes.HOME);
    }
  }

  Future<void> _sendVerificationEmail() async {
    setState(() {
      _isLoading = true;
    });

    try {
      User? user = _auth.currentUser;
      await user?.sendEmailVerification();
      Get.snackbar(
        'Verification Email Sent',
        'Please check your email for verification link.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send verification email. Please try again later.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.accent2),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Verify Your Email",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.accent2,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "A verification link has been sent to your email. Please check your email and click on the link to verify your account.",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.accent4,
              ),
            ),
            const SizedBox(height: 24),
            if (!_isEmailVerified)
              Column(
                children: [
                  const Text(
                    "Didn't receive the email?",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.accent4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _sendVerificationEmail,
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text("Resend Verification Email"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
