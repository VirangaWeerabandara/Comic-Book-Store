import 'package:comic_book_store/components/button.dart';
import 'package:comic_book_store/components/input.dart';

import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
            SizedBox(height: screenHeight * 0.2),
            const Text(
              "Sign in now",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.003),
            const Text(
              "Please sign in to continue our app",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            CustomInputField(hintText: "Email", controller: _emailController),
            SizedBox(height: screenHeight * 0.04),
            CustomInputField(
                hintText: "Password", controller: _passwordController),
            SizedBox(height: screenHeight * 0.02),
            SizedBox(height: screenHeight * 0.02),
            CustomButton(
              height: screenHeight * 0.08,
              width: screenWidth * 1,
              text: "Sign In",
              onPressed: () {
                print("Sign in");
              },
            ),
          ],
        ),
      ),
    );
  }
}
