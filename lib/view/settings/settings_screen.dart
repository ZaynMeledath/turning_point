// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/settings/settings_bloc.dart';
import 'package:turning_point/dialog/show_logout_dialog.dart';
import 'package:turning_point/utilities/screen_size.dart';
import 'package:turning_point/utilities/widget/my_app_bar.dart';

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
      appBar: myAppBar(
        context: context,
        title: 'Settings',
      ),
      body: SafeArea(
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, settingsState) {
            return Column(
              children: [
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
                      settingsOption(
                        iconPath: 'assets/icons/notifications_icon.png',
                        title: 'Notification',
                        isEnabled: settingsState.notification,
                        onSwitched: (value) {
                          settingsBloc
                              .add(SettingsTriggerEvent(notification: value));
                        },
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       SnackBar(
                      //         behavior: SnackBarBehavior.floating,
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(12),
                      //         ),
                      //         content: const Text(
                      //             'Biometrics cannot be turned on at the moment'),
                      //       ),
                      //     );
                      //   },
                      //   child: settingsOption(
                      //     iconPath: 'assets/icons/biometrics_icon.png',
                      //     title: 'Enable Biometrics',
                      //     isEnabled: false,
                      //   ),
                      // ),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              content: const Text(
                                  'Account deactivation cannot be done at the moment'),
                            ),
                          );
                        },
                        child: settingsOption(
                          iconPath: 'assets/icons/deactivate_account_icon.png',
                          title: 'Deactivate Account',
                        ),
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
                        onTap: () async {},
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
            );
          },
        ),
      ),
    );
  }
}
