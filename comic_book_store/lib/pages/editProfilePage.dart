// lib/pages/editProfilePage.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:comic_book_store/controllers/editProfileController.dart';
import 'package:comic_book_store/components/input.dart'; // Import CustomInputField
import 'package:comic_book_store/components/button.dart'; // Import CustomButton

class EditProfilePage extends StatelessWidget {
  final EditProfileController controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final keyboardPadding = mediaQuery.viewInsets.bottom;

    // Calculate responsive padding
    final horizontalPadding = screenWidth * 0.05; // 5% of screen width

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: EdgeInsets.only(
              left: horizontalPadding,
              right: horizontalPadding,
              top: 20,
              bottom: keyboardPadding + 20,
            ),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  CustomInputField(
                    hintText: 'Full Name',
                    controller: controller.fullNameController,
                  ),
                  const SizedBox(height: 20),
                  CustomInputField(
                    hintText: 'Email',
                    controller: controller.emailController,
                  ),
                  const SizedBox(height: 20),
                  CustomInputField(
                    hintText: 'Current Password',
                    controller: controller.currentPasswordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  CustomInputField(
                    hintText: 'New Password',
                    controller: controller.newPasswordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  CustomInputField(
                    hintText: 'Confirm Password',
                    controller: controller.confirmPasswordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    text: 'Update Profile',
                    onPressed: controller.updateProfile,
                    width: double.infinity,
                    height: 50,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
