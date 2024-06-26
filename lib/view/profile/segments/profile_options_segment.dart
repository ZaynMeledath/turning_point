import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:turning_point/utils/custom_navigator.dart';
import 'package:turning_point/utils/screen_size.dart';
import 'package:turning_point/view/about/about_us_screen.dart';
import 'package:turning_point/view/contest/contest_screen.dart';
import 'package:turning_point/view/games/games_home_screen.dart';
import 'package:turning_point/view/kyc/kyc_screen.dart';
import 'package:turning_point/view/points/points_screen.dart';
import 'package:turning_point/view/privacy_policy/privacy_policy_screen.dart';
import 'package:turning_point/view/profile/segments/profile_option.dart';
import 'package:turning_point/view/settings/settings_screen.dart';
import 'package:turning_point/view/terms_and_conditions/terms_and_conditions_screen.dart';

//====================Individual options in profile screen====================//
Widget profileOptionsSegment({
  required BuildContext context,
}) {
  return Column(
    children: [
//====================Points====================//
      InkWell(
        onTap: () {
          CustomNavigator.push(
            context: context,
            child: const PointsScreen(),
          );
        },
        highlightColor: Colors.white24,
        child: profileOption(
          iconPath: 'assets/icons/points_icon.png',
          title: 'Points',
          containerColor: const Color.fromRGBO(250, 219, 129, 1),
        ),
      ),

//====================Contest====================//
      InkWell(
        onTap: () {
          CustomNavigator.push(
            context: context,
            child: const ContestScreen(),
          );
        },
        highlightColor: Colors.white24,
        child: profileOption(
          iconPath: 'assets/icons/contest_icon.png',
          title: 'Contest',
          containerColor: const Color.fromRGBO(240, 207, 255, 1),
          containerPadding: screenSize.width * .016,
        ),
      ),

//====================Contest====================//
      InkWell(
        onTap: () {
          CustomNavigator.push(
            context: context,
            child: const GamesHomeScreen(),
          );
        },
        highlightColor: Colors.white24,
        child: profileOption(
          iconPath: 'assets/icons/joystick_icon.png',
          title: 'Games',
          containerColor: const Color.fromARGB(255, 146, 220, 255),
          // containerPadding: screenSize.width * .016,
        ),
      ),

//====================KYC====================//
      InkWell(
        onTap: () {
          CustomNavigator.push(
            context: context,
            child: const KycScreen(),
          );
        },
        highlightColor: Colors.white24,
        child: profileOption(
          iconPath: 'assets/icons/kyc_icon.png',
          title: 'KYC',
          containerColor: const Color.fromRGBO(216, 255, 210, 1),
          containerPadding: screenSize.width * .01,
        ),
      ),

      // BlocBuilder<ProfileBloc, ProfileState>(
      //   builder: (context, state) {
      //     return GestureDetector(
      //       onTap: () {
      //         profileBloc
      //             .add(ProfileLoadEvent(avoidGettingFromPreference: true));
      //         if (state.userModel!.kycStatus == null ||
      //             state.userModel!.kycStatus == KycStatus.PENDING) {
      //           CustomNavigator.push(
      //             context: context,
      //             child: const KycScreen(),
      //           );
      //         } else if (state.userModel!.kycStatus == KycStatus.SUBMITTED) {
      //           CustomNavigator.push(
      //             context: context,
      //             child: const KycSubmittedScreen(),
      //           );
      //         } else if (state.userModel!.kycStatus == KycStatus.APPROVED) {
      //           CustomNavigator.push(
      //             context: context,
      //             child: const KycVerifiedScreen(),
      //           );
      //         } else if (state.userModel!.kycStatus == KycStatus.REJECTED) {
      //           CustomNavigator.push(
      //             context: context,
      //             child: const KycRejectedScreen(),
      //           );
      //         }
      //       },
      //       child: profileOption(
      //         screenSize: screenSize,
      //         iconPath: 'assets/icons/kyc_icon.png',
      //         title: 'KYC',
      //         containerColor: const Color.fromRGBO(216, 255, 210, 1),
      //         containerPadding: screenSize.width * .01,
      //       ),
      //     );
      //   },
      // ),

//====================Privacy & Policy====================//
      InkWell(
        onTap: () {
          CustomNavigator.push(
            context: context,
            child: const PrivacyPolicyScreen(isAccepted: true),
          );
        },
        highlightColor: Colors.white24,
        child: profileOption(
          iconPath: 'assets/icons/privacy_policy_icon.png',
          title: 'Privacy & Policy',
          containerColor: const Color.fromRGBO(203, 227, 255, 1),
        ),
      ),

//====================Terms & Conditions====================//
      InkWell(
        onTap: () {
          CustomNavigator.push(
            context: context,
            child: const TermsAndConditionsScreen(isAccepted: true),
          );
        },
        highlightColor: Colors.white24,
        child: profileOption(
          iconPath: 'assets/icons/terms_icon.png',
          title: 'Terms & Conditions',
          containerColor: const Color.fromRGBO(255, 241, 241, 1),
        ),
      ),

//====================About Us====================//
      InkWell(
        onTap: () {
          CustomNavigator.push(
            context: context,
            child: const AboutUsScreen(),
          );
        },
        highlightColor: Colors.white24,
        child: profileOption(
          iconPath: 'assets/icons/about_us_icon.png',
          title: 'About Us',
          containerColor: const Color.fromRGBO(238, 215, 255, 1),
        ),
      ),

//====================Settings====================//
      InkWell(
        onTap: () {
          CustomNavigator.push(
            context: context,
            child: const SettingsScreen(),
          );
        },
        highlightColor: Colors.white24,
        child: profileOption(
          iconPath: 'assets/icons/settings_icon.png',
          title: 'Settings',
          containerColor: const Color.fromRGBO(206, 198, 255, 1),
        ),
      ),
    ],
  );
}
