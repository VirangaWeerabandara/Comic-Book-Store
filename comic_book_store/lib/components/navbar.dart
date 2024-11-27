import 'package:comic_book_store/pages/dictionaryPage.dart';
import 'package:comic_book_store/pages/homePage.dart';
import 'package:comic_book_store/pages/profile.dart';
import 'package:comic_book_store/pages/searchComics.dart';
import 'package:comic_book_store/routes/appRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:comic_book_store/constants/colors.dart';

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
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.secondary,
          backgroundColor: AppColors.background,
        ),
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: controller.screens,
        ),
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
  }
}
