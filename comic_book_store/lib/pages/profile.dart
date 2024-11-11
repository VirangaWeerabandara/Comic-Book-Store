import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size and orientation
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

    // Define breakpoints
    const double mobileBreakpoint = 480;
    const double tabletBreakpoint = 768;
    const double desktopBreakpoint = 1024;

    // Determine device type
    final deviceType = getDeviceType(screenWidth);

    // Calculate responsive values
    final paddingHorizontal = getPaddingHorizontal(screenWidth);
    final profileImageSize = getProfileImageSize(screenWidth, deviceType);
    final textScaleFactor = mediaQuery.textScaleFactor;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildStatusBar(context, paddingHorizontal),
              _buildProfileSection(
                context,
                profileImageSize: profileImageSize,
                paddingHorizontal: paddingHorizontal,
                deviceType: deviceType,
                textScaleFactor: textScaleFactor,
              ),
              _buildContentSection(
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

  DeviceType getDeviceType(double width) {
    if (width < 480) return DeviceType.mobile;
    if (width < 768) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  double getPaddingHorizontal(double screenWidth) {
    if (screenWidth < 480) return 16.0;
    if (screenWidth < 768) return 24.0;
    return 32.0;
  }

  double getProfileImageSize(double screenWidth, DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.mobile:
        return screenWidth * 0.25;
      case DeviceType.tablet:
        return screenWidth * 0.2;
      case DeviceType.desktop:
        return screenWidth * 0.15;
    }
  }

  Widget _buildStatusBar(BuildContext context, double paddingHorizontal) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '9:41',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: const [
              Icon(Icons.signal_cellular_alt, size: 18),
              SizedBox(width: 8),
              Icon(Icons.wifi, size: 18),
              SizedBox(width: 8),
              Icon(Icons.battery_full, size: 18),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection(
    BuildContext context, {
    required double profileImageSize,
    required double paddingHorizontal,
    required DeviceType deviceType,
    required double textScaleFactor,
  }) {
    final theme = Theme.of(context);
    final nameStyle = getResponsiveTextStyle(
      deviceType,
      theme.textTheme.headlineSmall!,
      textScaleFactor,
    );
    final emailStyle = getResponsiveTextStyle(
      deviceType,
      theme.textTheme.bodyMedium!,
      textScaleFactor,
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
      child: Column(
        children: [
          SizedBox(height: getResponsiveSpacing(deviceType, 24)),
          _buildProfileImage(profileImageSize),
          SizedBox(height: getResponsiveSpacing(deviceType, 16)),
          Text('Denys Stoliarov', style: nameStyle),
          SizedBox(height: getResponsiveSpacing(deviceType, 8)),
          Text(
            'poststoliarov@mail.com',
            style: emailStyle.copyWith(color: Colors.grey[600]),
          ),
          SizedBox(height: getResponsiveSpacing(deviceType, 16)),
          _buildEditProfileButton(context, deviceType, textScaleFactor),
        ],
      ),
    );
  }

  Widget _buildProfileImage(double size) {
    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[200]!, width: 2),
          ),
          child: ClipOval(
            child: Image.network(
              'https://via.placeholder.com/300',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(
                Icons.person,
                size: size * 0.6,
                color: Colors.grey[400],
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: _buildEditButton(size * 0.3),
        ),
      ],
    );
  }

  Widget _buildEditButton(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(Icons.edit, size: size * 0.6),
    );
  }

  Widget _buildEditProfileButton(
    BuildContext context,
    DeviceType deviceType,
    double textScaleFactor,
  ) {
    final buttonStyle = getResponsiveButtonStyle(deviceType);
    final textStyle = getResponsiveTextStyle(
      deviceType,
      Theme.of(context).textTheme.labelLarge!,
      textScaleFactor,
    );

    return OutlinedButton(
      onPressed: () {},
      style: buttonStyle,
      child: Text(
        'Edit profile',
        style: textStyle.copyWith(color: Colors.orange[800]),
      ),
    );
  }

  Widget _buildContentSection(
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
          SizedBox(height: getResponsiveSpacing(deviceType, 32)),
          _buildSectionTitle(
            context,
            'CONTENT',
            deviceType,
            textScaleFactor,
          ),
          _buildMenuItem(
            context,
            icon: Icons.book_outlined,
            title: 'Comics',
            count: '12',
            deviceType: deviceType,
            textScaleFactor: textScaleFactor,
          ),
          _buildMenuItem(
            context,
            icon: Icons.rate_review_outlined,
            title: 'Reviews',
            count: '2',
            deviceType: deviceType,
            textScaleFactor: textScaleFactor,
          ),
          SizedBox(height: getResponsiveSpacing(deviceType, 32)),
          _buildSectionTitle(
            context,
            'PREFERENCES',
            deviceType,
            textScaleFactor,
          ),
          _buildMenuItem(
            context,
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            deviceType: deviceType,
            textScaleFactor: textScaleFactor,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(
    BuildContext context,
    String title,
    DeviceType deviceType,
    double textScaleFactor,
  ) {
    final style = getResponsiveTextStyle(
      deviceType,
      Theme.of(context).textTheme.labelSmall!,
      textScaleFactor,
    );

    return Padding(
      padding: EdgeInsets.only(
        bottom: getResponsiveSpacing(deviceType, 16),
      ),
      child: Text(
        title,
        style: style.copyWith(
          color: Colors.grey[600],
          letterSpacing: 1.2,
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
  }) {
    final titleStyle = getResponsiveTextStyle(
      deviceType,
      Theme.of(context).textTheme.titleMedium!,
      textScaleFactor,
    );

    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: getResponsiveSpacing(deviceType, 12),
        ),
        child: Row(
          children: [
            Icon(icon, size: getResponsiveIconSize(deviceType)),
            SizedBox(width: getResponsiveSpacing(deviceType, 16)),
            Expanded(child: Text(title, style: titleStyle)),
            if (count != null)
              Text(count, style: titleStyle.copyWith(color: Colors.grey[600])),
            SizedBox(width: getResponsiveSpacing(deviceType, 8)),
            Icon(
              Icons.chevron_right,
              size: getResponsiveIconSize(deviceType),
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}

// Helper methods for responsive design
enum DeviceType { mobile, tablet, desktop }

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

double getResponsiveSpacing(DeviceType deviceType, double baseSpacing) {
  switch (deviceType) {
    case DeviceType.mobile:
      return baseSpacing;
    case DeviceType.tablet:
      return baseSpacing * 1.2;
    case DeviceType.desktop:
      return baseSpacing * 1.5;
  }
}

double getResponsiveIconSize(DeviceType deviceType) {
  switch (deviceType) {
    case DeviceType.mobile:
      return 24;
    case DeviceType.tablet:
      return 28;
    case DeviceType.desktop:
      return 32;
  }
}

ButtonStyle getResponsiveButtonStyle(DeviceType deviceType) {
  double horizontalPadding;
  double verticalPadding;

  switch (deviceType) {
    case DeviceType.mobile:
      horizontalPadding = 24;
      verticalPadding = 12;
      break;
    case DeviceType.tablet:
      horizontalPadding = 32;
      verticalPadding = 16;
      break;
    case DeviceType.desktop:
      horizontalPadding = 40;
      verticalPadding = 20;
      break;
  }

  return OutlinedButton.styleFrom(
    padding: EdgeInsets.symmetric(
      horizontal: horizontalPadding,
      vertical: verticalPadding,
    ),
  );
}
