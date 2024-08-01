import 'package:comic_book_store/pages/dictionaryPage.dart';
import 'package:comic_book_store/pages/signIn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

// Define your color theme
final Color primaryColor = Color(0xFF173048);
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
          currentIndex: controller.selectedIndex.value,
          onTap: (index) => controller.selectedIndex.value = index,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Iconsax.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.shop),
              label: 'Store',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.heart),
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.user),
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
    DictionaryPage(),
    DictionaryPage(),
    DictionaryPage(),
    DictionaryPage(),
  ];
}
