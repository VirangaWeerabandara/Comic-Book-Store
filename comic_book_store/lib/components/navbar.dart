import 'package:comic_book_store/pages/dictionaryPage.dart';
import 'package:comic_book_store/pages/homePage.dart';
import 'package:comic_book_store/pages/searchComics.dart';
import 'package:comic_book_store/pages/signIn.dart';
import 'package:comic_book_store/pages/textToSpeech.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

// Define your color theme
final Color primaryColor = Color(0xFFED6333);
final Color secondaryColor = Color(0xFF758BA7);
final Color accentColor = Color(0xFF9AC7E2);
final Color backgroundColor = Color(0xFFFFFFFF);
final Color cardColor = Color(0xFFB8BFC2);

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          elevation: 0,
          currentIndex: controller.selectedIndex.value,
          onTap: (index) => controller.selectedIndex.value = index,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home), // Updated icon
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books), // Updated icon
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), // Updated icon
              label: 'Dictionary',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person), // Updated icon
              label: 'Profile',
            ),
          ],
          selectedItemColor: primaryColor, // Use the defined color
          unselectedItemColor: secondaryColor, // Use the defined color
          backgroundColor: backgroundColor, // Use the defined color
        ),
      ),
      body: Obx(
        () => controller.screens[controller.selectedIndex.value],
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final List<Widget> screens = [
    HomePage(),
    SearchPage(),
    DictionaryPage(),
    HomePage(),
  ];
}
