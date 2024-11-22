import 'package:comic_book_store/pages/favouritePage.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final deviceType = getDeviceType(screenWidth);
    final paddingHorizontal = getPaddingHorizontal(screenWidth);
    final profileImageSize = getProfileImageSize(screenWidth, deviceType);
    final textScaleFactor = mediaQuery.textScaleFactor;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileHeader(
                context,
                profileImageSize: profileImageSize,
                paddingHorizontal: paddingHorizontal,
                deviceType: deviceType,
                textScaleFactor: textScaleFactor,
              ),
              _buildContent(
                context,
                paddingHorizontal: paddingHorizontal,
                deviceType: deviceType,
                textScaleFactor: textScaleFactor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(
    BuildContext context, {
    required double profileImageSize,
    required double paddingHorizontal,
    required DeviceType deviceType,
    required double textScaleFactor,
  }) {
    return Padding(
      padding: EdgeInsets.all(paddingHorizontal),
      child: Column(
        children: [
          CircleAvatar(
            radius: profileImageSize / 2,
            backgroundImage: const NetworkImage(
              'https://via.placeholder.com/150',
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'John Doe',
            style: getResponsiveTextStyle(
              deviceType,
              Theme.of(context).textTheme.headlineMedium!,
              textScaleFactor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'john.doe@example.com',
            style: getResponsiveTextStyle(
              deviceType,
              Theme.of(context).textTheme.bodyLarge!,
              textScaleFactor,
            ).copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {},
            child: const Text('Edit Profile'),
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
            count: '12',
            deviceType: deviceType,
            textScaleFactor: textScaleFactor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritePage(),
                ),
              );
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.book_outlined,
            title: 'My Comics',
            count: '3',
            deviceType: deviceType,
            textScaleFactor: textScaleFactor,
            onTap: () {},
          ),
          _buildSectionTitle(
            'Settings',
            deviceType,
            textScaleFactor,
            context,
          ),
          _buildMenuItem(
            context,
            icon: Icons.settings_outlined,
            title: 'Preferences',
            deviceType: deviceType,
            textScaleFactor: textScaleFactor,
            onTap: () {},
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
