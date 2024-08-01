import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;

  const CustomInputField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define your color theme here
    const Color primaryColor = Color(0xFF173048);
    const Color secondaryColor = Color(0xFF758BA7);
    const Color accentColor = Color(0xFF9AC7E2);
    const Color backgroundColor = Color(0xFFFFFFFF);
    const Color cardColor = Color(0xFFB8BFC2);

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: primaryColor, // Use the defined color
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: cardColor, width: 2.0), // Use the defined color
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: secondaryColor, width: 2.0), // Use the defined color
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: accentColor, width: 2.0), // Use the defined color
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: primaryColor, width: 2.0), // Use the defined color
          borderRadius: BorderRadius.circular(10.0),
        ),
        fillColor: cardColor, // Use the defined color
        filled: true,
      ),
    );
  }
}
