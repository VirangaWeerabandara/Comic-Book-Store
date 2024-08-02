import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

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

  late TextRecognizer textRecognizer;

  @override
  void initState() {
    super.initState();
    // Recognize text from image

    textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    doTextRecognition();
  }

  doTextRecognition() async {
    final inputImage = InputImage.fromFile(this.widget.image);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    String text = recognizedText.text;
    print(text);
    for (TextBlock block in recognizedText.blocks) {
      final Rect rect = block.boundingBox;
      final List<Point<int>> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<String> languages = block.recognizedLanguages;

      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        for (TextElement element in line.elements) {
          // Same getters as TextBlock
        }
      }
    }
  }

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
