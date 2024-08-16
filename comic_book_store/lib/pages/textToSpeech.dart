// import 'package:comic_book_store/components/button.dart';
// import 'package:comic_book_store/components/input.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';

// class TextToSpeech extends StatefulWidget {
//   const TextToSpeech({super.key});

//   @override
//   State<TextToSpeech> createState() => _TextToSpeechState();
// }

// class _TextToSpeechState extends State<TextToSpeech> {
//   final FlutterTts flutterTts = FlutterTts();
//   final TextEditingController textController = TextEditingController();

//   Map<String, dynamic> languageMap = {
//     'en-US': 'English',
//     'es-ES': 'Spanish',
//     'fr-FR': 'French',
//     'de-DE': 'German',
//     'it-IT': 'Italian',
//     'ja-JP': 'Japanese',
//     'ko-KR': 'Korean',
//     'zh-CN': 'Chinese',
//   };

//   List<String> languages = [];
//   String? selectedLanguage = 'en-US'; // Initialize with a default language
//   double pitch = 1;
//   double rate = 0.5;
//   double volume = 0.5;

//   @override
//   void initState() {
//     super.initState();
//     initTts();
//   }

//   Future<void> initTts() async {
//     try {
//       List<dynamic> availableLanguages = await flutterTts.getLanguages;
//       languages = availableLanguages
//           .where((language) => languageMap.keys.contains(language))
//           .map((language) => language as String)
//           .toList();
//       setState(() {});
//     } catch (e) {
//       print('Error fetching languages: $e');
//     }
//   }

//   @override
//   void dispose() {
//     textController.dispose();
//     super.dispose();
//   }

//   Future<void> speak() async {
//     if (textController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please enter text to speak')),
//       );
//       return;
//     }

//     try {
//       await flutterTts.setLanguage(selectedLanguage ?? 'en-US');
//       await flutterTts.setPitch(pitch);
//       await flutterTts.setSpeechRate(rate);
//       await flutterTts.setVolume(volume);
//       await flutterTts.speak(textController.text);
//     } catch (e) {
//       print('Error speaking: $e');
//     }
//   }

//   Future<void> stop() async {
//     try {
//       await flutterTts.stop();
//     } catch (e) {
//       print('Error stopping: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     const Color primaryColor = Color(0xFFED6333);
//     const Color secondaryColor = Color(0xFF758BA7);
//     const Color accentColor = Color(0xFF9AC7E2);
//     const Color backgroundColor = Color(0xFFFFFFFF);
//     const Color cardColor = Color(0xFFF5F5F5);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Text to Speech'),
//         backgroundColor: primaryColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(30),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomInputField(
//                 hintText: 'Enter text to speak',
//                 controller: textController,
//               ),
//               SizedBox(height: 20),
//               DropdownButtonFormField<String>(
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Select Language',
//                 ),
//                 items: languages.map((String language) {
//                   return DropdownMenuItem<String>(
//                     value: language,
//                     child: Text(languageMap[language] ?? language),
//                   );
//                 }).toList(),
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     selectedLanguage = newValue;
//                   });
//                 },
//                 value: selectedLanguage,
//               ),
//               SizedBox(height: 20),
//               Text('Pitch: ${pitch.toStringAsFixed(2)}'),
//               Slider(
//                 value: pitch,
//                 onChanged: (newPitch) {
//                   setState(() {
//                     pitch = newPitch;
//                   });
//                 },
//                 min: 0.5,
//                 max: 2.0,
//               ),
//               Text('Rate: ${rate.toStringAsFixed(2)}'),
//               Slider(
//                 value: rate,
//                 onChanged: (newRate) {
//                   setState(() {
//                     rate = newRate;
//                   });
//                 },
//                 min: 0.1,
//                 max: 1.0,
//               ),
//               Text('Volume: ${volume.toStringAsFixed(2)}'),
//               Slider(
//                 value: volume,
//                 onChanged: (newVolume) {
//                   setState(() {
//                     volume = newVolume;
//                   });
//                 },
//                 min: 0.0,
//                 max: 1.0,
//               ),
//               Center(
//                 child: CustomButton(
//                   text: 'Speak',
//                   onPressed: speak,
//                   width: 150, // Set the desired width
//                   height: 50, // Set the desired height
//                 ),
//               ),
//               Center(
//                 child: CustomButton(
//                   text: 'Stop',
//                   onPressed: stop,
//                   width: 150, // Set the desired width
//                   height: 50, // Set the desired height
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//