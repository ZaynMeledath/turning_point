// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/dialog/show_logout_dialog.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/my_app_bar.dart';

part 'segments/settings_option.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // bool enableNotification = true;
  // bool enableBiometrics = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            myAppBar(
              context: context,
              title: 'Settings',
            ),
            SizedBox(height: screenSize.height * .02),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * .051),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account',
                    style: GoogleFonts.inter(
                      fontSize: screenSize.width * .045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenSize.height * .015),
                  GestureDetector(
                    onTap: () async {},
                    child: settingsOption(
                      iconPath: 'assets/icons/notifications_icon.png',
                      title: 'Notification',
                      isEnabled: true,
                    ),
                  ),
                  settingsOption(
                    iconPath: 'assets/icons/biometrics_icon.png',
                    title: 'Enable Biometrics',
                    isEnabled: false,
                  ),
                  settingsOption(
                    iconPath: 'assets/icons/deactivate_account_icon.png',
                    title: 'Deactivate Account',
                  ),
                  SizedBox(height: screenSize.height * .025),
                  Text(
                    'Actions',
                    style: GoogleFonts.inter(
                      fontSize: screenSize.width * .045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenSize.height * .012),
                  GestureDetector(
                    onTap: () async {
                      final token =
                          await FirebaseAuth.instance.currentUser!.getIdToken();
                      log('TOKEN: $token');
                    },
                    child: settingsOption(
                      iconPath: 'assets/icons/flag_icon.png',
                      title: 'Report a Problem',
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await showLogoutDialog(context: context);
                    },
                    child: settingsOption(
                      iconPath: 'assets/icons/sign_out_icon.png',
                      title: 'Sign Out',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
