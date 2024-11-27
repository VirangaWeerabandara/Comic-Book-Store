import 'package:comic_book_store/pages/dictionaryPage.dart';
import 'package:comic_book_store/pages/profile.dart';
import 'package:comic_book_store/pages/searchComics.dart';
import 'package:comic_book_store/pages/signIn.dart';
import 'package:comic_book_store/routes/appRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:comic_book_store/pages/registerPage.dart';
import 'package:comic_book_store/pages/homePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Comic Books',
      theme: ThemeData.light(),
      initialRoute: AppRoutes.REGISTER,
      getPages: [
        GetPage(name: AppRoutes.REGISTER, page: () => const RegisterPage()),
        GetPage(name: AppRoutes.LOGIN, page: () => const SignIn()),
        GetPage(name: AppRoutes.HOME, page: () => const HomePage()),
        GetPage(name: AppRoutes.HOME, page: () => const HomePage()),
        GetPage(name: AppRoutes.SEARCH, page: () => SearchPage()),
        GetPage(name: AppRoutes.DICTIONARY, page: () => const DictionaryPage()),
        GetPage(name: AppRoutes.PROFILE, page: () => const ProfilePage()),
      ],
    );
  }
}
