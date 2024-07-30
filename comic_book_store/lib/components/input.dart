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
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFF173048), // Updated color
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color(0xFFB8BFC2), width: 2.0), // Updated color
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color(0xFF758BA7), width: 2.0), // Updated color
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color(0xFF9AC7E2), width: 2.0), // Updated color
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color(0xFF173048), width: 2.0), // Updated color
          borderRadius: BorderRadius.circular(10.0),
        ),
        fillColor: const Color(0xFFB8BFC2), // Updated color
        filled: true,
      ),
    );
  }
}
