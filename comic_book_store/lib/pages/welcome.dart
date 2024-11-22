import 'package:comic_book_store/components/button.dart';
import 'package:comic_book_store/components/input.dart';
import 'package:comic_book_store/constants/colors.dart';
import 'package:comic_book_store/pages/recognizerScreen.dart';
import 'package:comic_book_store/pages/registerPage.dart';
import 'package:comic_book_store/pages/signIn.dart';

import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/page_01.png',
                          width: screenWidth * 0.8,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        const Text(
                          "Welcome to",
                          style: TextStyle(
                            fontSize: 28,
                            color: AppColors.accent2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          "Comic Book Store",
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accent2,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        const Text(
                          "Buy, read and enjoy comics and manga all",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.accent4,
                          ),
                        ),
                        const Text(
                          "around the world",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.accent4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          height: screenHeight * 0.08,
                          width: screenWidth,
                          text: "Sign In",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignIn(),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                          height: screenHeight * 0.08,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            border: Border.all(
                              color: AppColors.accent2,
                              width: 2.0,
                            ),
                            color: Colors.white,
                          ),
                          child: TextButton(
                            onPressed: () => {},
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
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.accent4,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.accent2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
