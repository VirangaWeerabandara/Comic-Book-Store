import 'dart:io';

import 'package:comic_book_store/pages/recognizerScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextRecognition extends StatefulWidget {
  const TextRecognition({super.key});

  @override
  State<TextRecognition> createState() => _TextRecognitionState();
}

class _TextRecognitionState extends State<TextRecognition> {
  final Color primaryColor = const Color(0xFFED6333);
  final Color secondaryColor = const Color(0xFF758BA7);
  final Color accentColor = const Color(0xFF9AC7E2);
  final Color backgroundColor = const Color(0xFFFFFFFF);
  final Color cardColor = const Color(0xFFF5F5F5);

  late ImagePicker imagePicker;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Card(s
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(15.0),
                //     child: Container(
                //       height: 70,
                //       color: primaryColor,
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: [
                //           InkWell(
                //             child: Icon(Icons.scanner,
                //                 color: accentColor, size: 25),
                //             onTap: () {
                //               print("hi");
                //             },
                //           ),
                //           InkWell(
                //             child: Icon(Icons.document_scanner,
                //                 color: accentColor, size: 25),
                //             onTap: () {
                //               print("hi");
                //             },
                //           ),
                //           InkWell(
                //             child: Icon(Icons.assignment_sharp,
                //                 color: accentColor, size: 25),
                //             onTap: () {
                //               print("hi");
                //             },
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                Card(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      height: screenHeight - 300,
                      color: secondaryColor,
                    ),
                  ),
                ),
                Card(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      height: 100,
                      color: primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            child: Icon(Icons.rotate_left,
                                color: accentColor, size: 30),
                            onTap: () {
                              print("hi");
                            },
                          ),
                          InkWell(
                            child: Icon(Icons.camera,
                                color: accentColor, size: 50),
                            onTap: () {
                              print("hi");
                            },
                          ),
                          InkWell(
                            child: Icon(Icons.image_outlined,
                                color: accentColor, size: 30),
                            onTap: () async {
                              XFile? xfile = await imagePicker.pickImage(
                                  source: ImageSource.gallery);
                              if (xfile != null) {
                                File image = File(xfile.path);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (ctx) {
                                  return RecognizerScreen(image);
                                }));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
