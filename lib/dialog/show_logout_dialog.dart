import 'package:page_transition/page_transition.dart';
import 'package:turning_point/bloc/auth/auth_bloc.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point/utils/screen_size.dart';
import 'package:turning_point/view/settings/settings_screen.dart';
import 'package:turning_point/view/signin/sign_in_screen.dart';

Future<Object?> showLogoutDialog({
  required BuildContext context,
}) async {
  return showGeneralDialog(
    context: context,
    pageBuilder: (context, a1, a2) {
      return Container();
    },
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (context, a1, a2, child) {
      final curve = Curves.easeInOut.transform(a1.value);
      return Transform.scale(
        scale: curve,
        child: dialog(
          context: context,
        ),
      );
    },
  );
}

Widget dialog({required BuildContext context}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: screenSize.width * .6,
        padding: EdgeInsets.only(
          left: screenSize.width * .03,
          right: screenSize.width * .03,
          bottom: screenSize.height * .025,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Lottie.asset(
              'assets/lottie/logout_animation.json',
              width: screenSize.width * .3,
            ),
            DefaultTextStyle(
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .051,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              child: const Text(
                'Log Out',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: screenSize.height * .01),
            DefaultTextStyle(
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .035,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                height: 1.4,
              ),
              child: const Text(
                'Are you sure you want to log out?',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: screenSize.height * .035),
            Padding(
              padding: EdgeInsets.only(right: screenSize.width * .028),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: DefaultTextStyle(
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .036,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(0, 99, 255, 1),
                      ),
                      child: const Center(
                        child: Text(
                          'Cancel',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenSize.width * .05),
                  GestureDetector(
                    onTap: () {
                      authBloc.add(SignOutEvent());
                      preloadBloc.add(PreloadResetEvent());
                      Navigator.of(context).pushAndRemoveUntil(
                        PageTransition(
                          child: const SignInScreen(),
                          childCurrent: const SettingsScreen(),
                          type: PageTransitionType.fade,
                          duration: const Duration(milliseconds: 1800),
                        ),
                        (_) => false,
                      );
                    },
                    child: DefaultTextStyle(
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .036,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(0, 99, 255, 1),
                      ),
                      child: const Center(
                        child: Text(
                          'Log Out',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
