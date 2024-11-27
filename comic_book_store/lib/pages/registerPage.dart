import 'package:comic_book_store/controllers/registerController.dart';
import 'package:comic_book_store/routes/appRoutes.dart';
import 'package:flutter/material.dart';
import 'package:comic_book_store/constants/colors.dart';
import 'package:comic_book_store/components/button.dart';
import 'package:comic_book_store/components/input.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final RegisterController _controller = Get.put(RegisterController());

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _contactNumberController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      final error = await _controller.registerUser(
        fullName: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        contactNumber: _contactNumberController.text,
      );

      if (error == null) {
        Get.snackbar(
          'Success',
          'Registration successful!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed(AppRoutes.HOME);
      } else {
        setState(() {
          _errorMessage = error;
        });
      }

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ),
                CustomInputField(
                  hintText: "Full Name",
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Full Name is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                CustomInputField(
                  hintText: "Email",
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                        .hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                CustomInputField(
                  hintText: "Password",
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                CustomInputField(
                  hintText: "Confirm Password",
                  controller: _confirmPasswordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Confirm Password is required";
                    }
                    if (value != _passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                CustomInputField(
                  hintText: "Contact Number",
                  controller: _contactNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Contact Number is required";
                    }
                    if (!RegExp(r"^\d{10}$").hasMatch(value)) {
                      return "Enter a valid 10-digit contact number";
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.04),
                CustomButton(
                  height: screenHeight * 0.08,
                  width: screenWidth,
                  text: _isLoading ? "Registering..." : "Register",
                  backgroundColor: AppColors.primary,
                  textColor: Colors.white,
                  onPressed: _isLoading ? null : _register,
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.accent3,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.offAllNamed(AppRoutes.LOGIN),
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
      ),
    );
  }
}
