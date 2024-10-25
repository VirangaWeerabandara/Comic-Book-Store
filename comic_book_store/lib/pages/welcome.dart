import 'package:comic_book_store/components/button.dart';
import 'package:comic_book_store/components/input.dart';
import 'package:comic_book_store/constants/colors.dart';
import 'package:comic_book_store/pages/signIn.dart';

import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _SingInState();
}

class _SingInState extends State<WelcomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/page_01.png',
                    width: screenWidth,
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            const Text(
              "Welcome to",
              style: TextStyle(fontSize: 28, color: AppColors.accent2),
            ),
            const Text(
              "Comic Book Store",
              style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accent2),
            ),
            const Text(
              "Buy, read and enjoy comics and manga all",
              style: TextStyle(fontSize: 18, color: AppColors.accent4),
            ),
            const Text(
              "around the world",
              style: TextStyle(fontSize: 18, color: AppColors.accent4),
            ),
            SizedBox(height: screenHeight * 0.003),
            SizedBox(height: screenHeight * 0.02),
            CustomButton(
              height: screenHeight * 0.08,
              width: screenWidth * 1,
              text: "Sign In",
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignIn()));
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              height: screenHeight * 0.08,
              width: screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(color: AppColors.accent2, width: 2.0),
                color: Colors.white,
              ),
              child: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.g_translate,
                      color: AppColors.accent2,
                      size: 24.0,
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    const Text(
                      "Sign In with Google",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accent2,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
