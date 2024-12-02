// import 'dart:io';

// import 'package:comic_book_store/constants/colors.dart';
// import 'package:comic_book_store/pages/recognizerScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class TextRecognition extends StatefulWidget {
//   const TextRecognition({super.key});

//   @override
//   State<TextRecognition> createState() => _TextRecognitionState();
// }

// class _TextRecognitionState extends State<TextRecognition> {
//   late ImagePicker imagePicker;

//   @override
//   void initState() {
//     super.initState();
//     imagePicker = ImagePicker();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     return Container(
//       color: AppColors.background,
//       child: SafeArea(
//         child: Scaffold(
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 Card(
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(15.0),
//                     child: Container(
//                       height: 100,
//                       color: AppColors.primary,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           InkWell(
//                             child: Icon(Icons.rotate_left,
//                                 color: accentColor, size: 30),
//                             onTap: () {
//                               print("hi");
//                             },
//                           ),
//                           InkWell(
//                             child: Icon(Icons.camera,
//                                 color: accentColor, size: 50),
//                             onTap: () async {
//                               XFile? xfile = await imagePicker.pickImage(
//                                   source: ImageSource.camera);
//                               if (xfile != null) {
//                                 File image = File(xfile.path);
//                                 Navigator.push(context,
//                                     MaterialPageRoute(builder: (ctx) {
//                                   return RecognizerScreen(image);
//                                 }));
//                               }
//                             },
//                           ),
//                           InkWell(
//                             child: Icon(Icons.image_outlined,
//                                 color: accentColor, size: 30),
//                             onTap: () async {
//                               XFile? xfile = await imagePicker.pickImage(
//                                   source: ImageSource.gallery);
//                               if (xfile != null) {
//                                 File image = File(xfile.path);
//                                 Navigator.push(context,
//                                     MaterialPageRoute(builder: (ctx) {
//                                   return RecognizerScreen(image);
//                                 }));
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
