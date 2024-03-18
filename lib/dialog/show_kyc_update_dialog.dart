import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point/helper/screen_size.dart';

Future<Object?> showKycUpdateDialog({
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
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * .03),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Lottie.asset(
                  'assets/lottie/profile_inactive_animation.json',
                  width: screenSize.width * .3,
                ),
                DefaultTextStyle(
                  style: GoogleFonts.roboto(
                    fontSize: screenSize.width * .051,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  child: const Text(
                    'Submit KYC?',
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
                    'Your KYC details will be submitted\nfor approval by clicking on Submit',
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: screenSize.height * .035),
                Padding(
                  padding: EdgeInsets.only(
                    right: screenSize.width * .028,
                    bottom: screenSize.height * .025,
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: screenSize.width * .41),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(false);
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
                          Navigator.of(context).pop(true);
                        },
                        child: DefaultTextStyle(
                          style: GoogleFonts.roboto(
                            fontSize: screenSize.width * .036,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(0, 99, 255, 1),
                          ),
                          child: const Center(
                            child: Text(
                              'Submit',
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
      ),
    ],
  );
}
