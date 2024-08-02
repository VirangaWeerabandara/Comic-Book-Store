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
    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: backgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: primaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.file(this.widget.image),
            ),
          ),
        ),
      ),
    );
  }
}
