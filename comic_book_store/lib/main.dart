import 'package:comic_book_store/components/navbar.dart';
import 'package:comic_book_store/pages/dictionaryPage.dart';
import 'package:comic_book_store/pages/homePage.dart';
import 'package:comic_book_store/pages/library.dart';
import 'package:comic_book_store/pages/onBoarding.dart';
import 'package:comic_book_store/pages/signIn.dart';
import 'package:comic_book_store/pages/textRecognition.dart';
import 'package:comic_book_store/pages/textToSpeech.dart';
import 'package:comic_book_store/pages/welcome.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Comic Books',
      theme: ThemeData.light(),
      home: const HomePage(),
    );
  }
}
