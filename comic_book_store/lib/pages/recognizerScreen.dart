import 'dart:io';

import 'package:flutter/material.dart';

class RecognizerScreen extends StatefulWidget {
  final File image;
  RecognizerScreen(this.image);

  @override
  State<RecognizerScreen> createState() => _RecognizerScreenState();
}

class _RecognizerScreenState extends State<RecognizerScreen> {
  final Color primaryColor = const Color(0xFFED6333);
  final Color secondaryColor = const Color(0xFF758BA7);
  final Color accentColor = const Color(0xFF9AC7E2);
  final Color backgroundColor = const Color.fromARGB(255, 239, 145, 145);
  final Color cardColor = const Color(0xFFF5F5F5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Recognition'),
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: Container(
          color: backgroundColor,
          padding: const EdgeInsets.all(16.0),
          child: Image.file(
            widget.image,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
