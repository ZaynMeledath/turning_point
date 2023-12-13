import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turning_point/view/kyc/kyc_screen.dart';
import 'package:turning_point/view/points/points_screen.dart';
import 'package:turning_point/view/profile/segments/profile_option.dart';

//====================Individual options in profile screen====================//
Widget profileOptionsSegment({
  required BuildContext context,
  required Size screenSize,
}) {
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            PageTransition(
              child: const PointsScreen(),
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 350),
              reverseDuration: const Duration(milliseconds: 350),
            ),
          );
        },
        child: profileOption(
          screenSize: screenSize,
          iconPath: 'assets/icons/points_icon.png',
          title: 'Points',
          containerColor: const Color.fromRGBO(250, 219, 129, 1),
        ),
      ),
      GestureDetector(
        onTap: () {},
        child: profileOption(
          screenSize: screenSize,
          iconPath: 'assets/icons/gift_box_icon.png',
          title: 'Rewards',
          containerColor: const Color.fromRGBO(203, 225, 252, 1),
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            PageTransition(
              child: const KycScreen(),
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 350),
              reverseDuration: const Duration(milliseconds: 350),
            ),
          );
        },
        child: profileOption(
          screenSize: screenSize,
          iconPath: 'assets/icons/kyc_icon.png',
          title: 'KYC',
          containerColor: const Color.fromRGBO(216, 255, 210, 1),
        ),
      ),
      GestureDetector(
        onTap: () {},
        child: profileOption(
          screenSize: screenSize,
          iconPath: 'assets/icons/privacy_policy_icon.png',
          title: 'Privacy & Policy',
          containerColor: const Color.fromRGBO(203, 227, 255, 1),
        ),
      ),
      GestureDetector(
        onTap: () {},
        child: profileOption(
          screenSize: screenSize,
          iconPath: 'assets/icons/terms_icon.png',
          title: 'Terms & Conditions',
          containerColor: const Color.fromRGBO(255, 241, 241, 1),
        ),
      ),
      GestureDetector(
        onTap: () {},
        child: profileOption(
          screenSize: screenSize,
          iconPath: 'assets/icons/about_us_icon.png',
          title: 'About Us',
          containerColor: const Color.fromRGBO(238, 215, 255, 1),
        ),
      ),
      GestureDetector(
        onTap: () {},
        child: profileOption(
          screenSize: screenSize,
          iconPath: 'assets/icons/settings_icon.png',
          title: 'Settings',
          containerColor: const Color.fromRGBO(206, 198, 255, 1),
        ),
      ),
    ],
  );
}
