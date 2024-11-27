import 'package:comic_book_store/pages/dictionaryPage.dart';
import 'package:comic_book_store/pages/homePage.dart';
import 'package:comic_book_store/pages/profile.dart';
import 'package:comic_book_store/pages/searchComics.dart';
import 'package:comic_book_store/routes/appRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


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
          onTap: (index) => controller.onTabTapped(index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Dictionary',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          selectedItemColor: primaryColor,
          unselectedItemColor: secondaryColor,
          backgroundColor: backgroundColor,
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
    ProfilePage(),
  ];

  void onTabTapped(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        Get.toNamed(AppRoutes.HOME);
        break;
      case 1:
        Get.toNamed(AppRoutes.SEARCH);
        break;
      case 2:
        Get.toNamed(AppRoutes.DICTIONARY);
        break;
      case 3:
        Get.toNamed(AppRoutes.PROFILE);
        break;
    }
  }
}