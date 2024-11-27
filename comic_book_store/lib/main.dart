import 'package:comic_book_store/components/navbar.dart';
import 'package:comic_book_store/pages/comicBookPage.dart';
import 'package:comic_book_store/pages/dictionaryPage.dart';
import 'package:comic_book_store/pages/homePage.dart';
import 'package:comic_book_store/pages/library.dart';
import 'package:comic_book_store/pages/onBoarding.dart';
import 'package:comic_book_store/pages/registerPage.dart';
import 'package:comic_book_store/pages/signIn.dart';
import 'package:comic_book_store/pages/test.dart';
import 'package:comic_book_store/pages/textRecognition.dart';
import 'package:comic_book_store/pages/textToSpeech.dart';
import 'package:comic_book_store/pages/welcome.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Add this import statement
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home:  RegisterPage(),
    );
  }
}
