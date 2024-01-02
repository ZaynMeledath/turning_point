import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'dart:math' as math show pi;

Future<Object?> showCameraPermissionRequestDialog({
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
        child: dialog(context),
      );
    },
  );
}

Widget dialog(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(
        left: screenSize.width * .071,
        right: screenSize.width * .071,
        top: screenSize.height * .68,
        bottom: screenSize.height * .05),
    padding: EdgeInsets.symmetric(
      horizontal: screenSize.width * .041,
      vertical: screenSize.height * .02,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      children: [
        Container(
          width: screenSize.width * .21,
          height: screenSize.width * .21,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(217, 217, 217, 1),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.camera_alt_rounded,
                size: screenSize.width * .1,
                color: const Color.fromRGBO(66, 66, 66, 1),
              ),
              Transform.rotate(
                angle: -math.pi / 5,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromRGBO(66, 66, 66, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenSize.height * .01),
        DefaultTextStyle(
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .036,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          child: const Text(
            'Furnipart needs permission to access camera\nto scan the QR code. Kindly turn on the camera\npermission',
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: screenSize.width * .24,
                    height: screenSize.width * .065,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromRGBO(141, 151, 154, 1),
                    ),
                    child: Center(
                      child: DefaultTextStyle(
                        style: GoogleFonts.roboto(
                          fontSize: screenSize.width * .026,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width * .051),
                Container(
                  width: screenSize.width * .24,
                  height: screenSize.width * .065,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromRGBO(0, 99, 255, 1),
                  ),
                  child: Center(
                    child: DefaultTextStyle(
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .026,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      child: const Text('Go to Settings'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
