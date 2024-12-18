import 'package:comic_book_store/constants/colors.dart';
import 'package:comic_book_store/models/userModel.dart';
import 'package:comic_book_store/pages/editProfilePage.dart';
import 'package:comic_book_store/pages/favouritePage.dart';
import 'package:comic_book_store/pages/recognizerScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:comic_book_store/controllers/profileController.dart';
import 'package:comic_book_store/controllers/signOutController.dart'; // Import SignOutController
import 'package:comic_book_store/components/button.dart'; // Import CustomButton
import 'package:image_picker/image_picker.dart';
import 'package:universal_io/io.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());
    final SignOutController signOutController = Get.put(SignOutController());
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final deviceType = getDeviceType(screenWidth);
    final paddingHorizontal = getPaddingHorizontal(screenWidth);
    final profileImageSize = getProfileImageSize(screenWidth, deviceType);
    final textScaleFactor = mediaQuery.textScaleFactor;
    final ImagePicker imagePicker = ImagePicker(); // Initialize ImagePicker

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            final user = profileController.userModel.value;
            if (user == null) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                _buildProfileHeader(
                  context,
                  user: user,
                  profileImageSize: profileImageSize,
                  paddingHorizontal: paddingHorizontal,
                  deviceType: deviceType,
                  textScaleFactor: textScaleFactor,
                  controller: profileController,
                ),
                _buildContent(
                  context,
                  paddingHorizontal: paddingHorizontal,
                  deviceType: deviceType,
                  textScaleFactor: textScaleFactor,
                  imagePicker: imagePicker, // Pass ImagePicker instance
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Sign Out',
                  onPressed: signOutController.signOutUser,
                  width: 200,
                  height: 50,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  icon: Icons.logout, // Add the logout icon
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(
    BuildContext context, {
    required UserModel user,
    required double profileImageSize,
    required double paddingHorizontal,
    required DeviceType deviceType,
    required double textScaleFactor,
    required ProfileController controller,
  }) {
    return Padding(
      padding: EdgeInsets.all(paddingHorizontal),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: profileImageSize / 2,
                backgroundImage: user.profilePictureUrl != null
                    ? NetworkImage(user.profilePictureUrl!)
                    : const AssetImage('assets/images/default_profile.png')
                        as ImageProvider,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => controller.uploadProfilePicture(),
                  child: CircleAvatar(
                    radius: profileImageSize / 6,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.edit,
                      size: profileImageSize / 6,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            user.fullName,
            style: getResponsiveTextStyle(
              deviceType,
              Theme.of(context).textTheme.headlineMedium!,
              textScaleFactor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            user.email,
            style: getResponsiveTextStyle(
              deviceType,
              Theme.of(context).textTheme.bodyLarge!,
              textScaleFactor,
            ).copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Edit Profile',
            onPressed: () => Get.to(() => EditProfilePage()),
            width: 200,
            height: 50,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            icon: Icons.edit, // Add the edit icon
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context, {
    required double paddingHorizontal,
    required DeviceType deviceType,
    required double textScaleFactor,
    required ImagePicker imagePicker, // Add ImagePicker parameter
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            'Content',
            deviceType,
            textScaleFactor,
            context,
          ),
          _buildMenuItem(
            context,
            icon: Icons.favorite_border,
            title: 'Favorites',
            deviceType: deviceType,
            textScaleFactor: textScaleFactor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesPage(),
                ),
              );
            },
          ),
          _buildSectionTitle(
            'New Features',
            deviceType,
            textScaleFactor,
            context,
          ),
          _buildMenuItem(
            context,
            icon: Icons.camera_alt,
            title: 'OCR with camera',
            deviceType: deviceType,
            textScaleFactor: textScaleFactor,
            onTap: () async {
              XFile? xfile =
                  await imagePicker.pickImage(source: ImageSource.camera);
              if (xfile != null) {
                File image = File(xfile.path);
                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                  return RecognizerScreen(image);
                }));
              }
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.image_outlined,
            title: 'OCR with image',
            deviceType: deviceType,
            textScaleFactor: textScaleFactor,
            onTap: () async {
              XFile? xfile =
                  await imagePicker.pickImage(source: ImageSource.gallery);
              if (xfile != null) {
                File image = File(xfile.path);
                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                  return RecognizerScreen(image);
                }));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(
    String title,
    DeviceType deviceType,
    double textScaleFactor,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title.toUpperCase(),
        style: getResponsiveTextStyle(
          deviceType,
          Theme.of(context).textTheme.titleSmall!,
          textScaleFactor,
        ).copyWith(
          color: Colors.grey[600],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? count,
    required DeviceType deviceType,
    required double textScaleFactor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: getResponsiveTextStyle(
          deviceType,
          Theme.of(context).textTheme.bodyLarge!,
          textScaleFactor,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (count != null)
            Text(
              count,
              style: getResponsiveTextStyle(
                deviceType,
                Theme.of(context).textTheme.bodyMedium!,
                textScaleFactor,
              ).copyWith(color: Colors.grey[600]),
            ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: onTap,
    );
  }
}

enum DeviceType { mobile, tablet, desktop }

DeviceType getDeviceType(double width) {
  if (width < 600) return DeviceType.mobile;
  if (width < 900) return DeviceType.tablet;
  return DeviceType.desktop;
}

double getPaddingHorizontal(double width) {
  if (width < 600) return 16;
  if (width < 900) return 24;
  return 32;
}

double getProfileImageSize(double width, DeviceType deviceType) {
  switch (deviceType) {
    case DeviceType.mobile:
      return width * 0.25;
    case DeviceType.tablet:
      return width * 0.2;
    case DeviceType.desktop:
      return width * 0.15;
  }
}

TextStyle getResponsiveTextStyle(
  DeviceType deviceType,
  TextStyle baseStyle,
  double textScaleFactor,
) {
  double scaleFactor;
  switch (deviceType) {
    case DeviceType.mobile:
      scaleFactor = 1.0;
      break;
    case DeviceType.tablet:
      scaleFactor = 1.2;
      break;
    case DeviceType.desktop:
      scaleFactor = 1.4;
      break;
  }
  return baseStyle.copyWith(
    fontSize: (baseStyle.fontSize ?? 14) * scaleFactor * textScaleFactor,
  );
}
