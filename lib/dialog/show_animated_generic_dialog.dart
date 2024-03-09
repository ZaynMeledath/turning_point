import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point/helper/screen_size.dart';

Future<Object?> showAnimatedGenericDialog({
  required BuildContext context,
  required String iconPath,
  required String title,
  required String content,
  required String buttonTitle,
  double? iconWidth,
  // Size? containerSize,
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
          iconPath: iconPath,
          title: title,
          content: content,
          buttonTitle: buttonTitle,
          iconWidth: iconWidth,
        ),
      );
    },
  );
}

Widget dialog({
  required BuildContext context,
  required String iconPath,
  required String title,
  required String content,
  required String buttonTitle,
  double? iconWidth,
}) {
  final isLottie = iconPath.split('.').last == 'json';
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: screenSize.width * .16,
      vertical: screenSize.height * .36,
    ),
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .03),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      children: [
        SizedBox(height: screenSize.height * .011),
        isLottie
            ? Lottie.asset(
                iconPath,
                width: iconWidth ?? screenSize.width * .15,
              )
            : Image.asset(
                iconPath,
                width: iconWidth ?? screenSize.width * .15,
              ),
        SizedBox(
          height:
              isLottie ? screenSize.height * .005 : screenSize.height * .014,
        ),
        DefaultTextStyle(
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .051,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: screenSize.height * .012),
        DefaultTextStyle(
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .035,
            fontWeight: FontWeight.w400,
            color: Colors.black,
            height: 1.4,
          ),
          child: Text(
            content,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: screenSize.height * .028),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: screenSize.width * .25,
            height: screenSize.width * .085,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromRGBO(0, 99, 255, 1),
            ),
            child: DefaultTextStyle(
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .031,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  buttonTitle,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
