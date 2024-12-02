import 'dart:io';
import 'dart:math';

import 'package:comic_book_store/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:flutter/services.dart';

class RecognizerScreen extends StatefulWidget {
  final File image;
  RecognizerScreen(this.image);

  @override
  State<RecognizerScreen> createState() => _RecognizerScreenState();
}

class _RecognizerScreenState extends State<RecognizerScreen> {
  late TextRecognizer textRecognizer;

  @override
  void initState() {
    super.initState();
    // Recognize text from image
    textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    doTextRecognition();
  }

  String results = '';

  doTextRecognition() async {
    final inputImage = InputImage.fromFile(this.widget.image);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    results = recognizedText.text;

    setState(() {
      results;
    });

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

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: results));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Recognition'),
        titleTextStyle: TextStyle(color: AppColors.background),
        backgroundColor: AppColors.primary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Image.file(
                  widget.image,
                  fit: BoxFit.contain,
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Results',
                                style: TextStyle(color: AppColors.background),
                              ),
                              IconButton(
                                icon: Icon(Icons.copy,
                                    color: AppColors.background),
                                onPressed: copyToClipboard,
                              ),
                            ],
                          ),
                        ),
                        color: AppColors.primary,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(results),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
