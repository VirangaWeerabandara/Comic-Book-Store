import 'dart:io';

import 'package:comic_book_store/components/navbar.dart';
import 'package:comic_book_store/pages/editProfilePage.dart';
import 'package:comic_book_store/pages/onBoarding.dart';
import 'package:comic_book_store/pages/recognizerScreen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:comic_book_store/routes/appRoutes.dart';
import 'package:comic_book_store/pages/registerPage.dart';
import 'package:comic_book_store/pages/signIn.dart';
import 'package:comic_book_store/pages/homePage.dart';
import 'package:comic_book_store/pages/emailVerificationPage.dart';
import 'package:comic_book_store/pages/searchComics.dart';
import 'package:comic_book_store/pages/dictionaryPage.dart';
import 'package:comic_book_store/pages/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    DevicePreview(
      enabled: true, // Enable device preview only in non-release mode
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if the user is authenticated
    final User? user = FirebaseAuth.instance.currentUser;
    final initialRoute = user == null ? AppRoutes.ONBOARDING : AppRoutes.HOME;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Comic Books',
      theme: ThemeData.light(),
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: AppRoutes.REGISTER, page: () => const RegisterPage()),
        GetPage(name: AppRoutes.LOGIN, page: () => const SignIn()),
        GetPage(name: AppRoutes.HOME, page: () => const NavigationMenu()),
        GetPage(name: AppRoutes.SEARCH, page: () => SearchPage()),
        GetPage(name: AppRoutes.DICTIONARY, page: () => const DictionaryPage()),
        GetPage(name: AppRoutes.PROFILE, page: () => const ProfilePage()),
        GetPage(name: AppRoutes.ONBOARDING, page: () => const Onboarding()),
        GetPage(
            name: AppRoutes.EMAIL_VERIFICATION,
            page: () => const EmailVerificationPage()),
        GetPage(name: AppRoutes.EDITPROFILE, page: () => EditProfilePage()),
        // RecognizerScreen requires an image parameter, so we need to handle it differently
        GetPage(
          name: AppRoutes.RECOGNIZERSCREEN,
          page: () => RecognizerScreen(File('')), // Placeholder, handle this properly in your navigation logic
        ),
      ],
    );
  }
}