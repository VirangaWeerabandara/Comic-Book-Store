import 'package:comic_book_store/components/button.dart';
import 'package:comic_book_store/components/input.dart';
import 'package:comic_book_store/constants/colors.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.accent2),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accent2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Please fill in the form to continue",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.accent4,
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              
              CustomInputField(
                hintText: "Full Name",
                controller: _nameController,
              ),
              SizedBox(height: screenHeight * 0.02),
              
              CustomInputField(
                hintText: "Email",
                controller: _emailController,
              
              ),
              SizedBox(height: screenHeight * 0.02),
              
              CustomInputField(
                hintText: "Password",
                controller: _passwordController,
               
              ),
              SizedBox(height: screenHeight * 0.02),
              
              CustomInputField(
                hintText: "Confirm Password",
                controller: _confirmPasswordController,
                
              ),
              SizedBox(height: screenHeight * 0.04),
              
              CustomButton(
                height: screenHeight * 0.08,
                width: screenWidth,
                text: "Register",
                onPressed: () {},
              ),
              SizedBox(height: screenHeight * 0.02),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.accent4,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      "Sign In",
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
      ),
    );
  }
}