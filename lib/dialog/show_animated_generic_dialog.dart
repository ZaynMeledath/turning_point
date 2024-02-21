import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';

Future<Object?> showAnimatedGenericDialog({
  required BuildContext context,
  required String iconPath,
  required String title,
  required String content,
  required String buttonTitle,
  Size? iconWidth,
  Size? containerSize,
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
  Size? iconWidth,
}) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: screenSize.width * .08,
      vertical: screenSize.height * .36,
    ),
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .03),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      children: [
        SizedBox(height: screenSize.height * .025),
        Image.asset(
          iconPath,
          width: screenSize.width * .15,
        ),
        SizedBox(height: screenSize.height * .018),
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
        SizedBox(height: screenSize.height * .01),
        DefaultTextStyle(
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .035,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          child: Text(
            content,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: screenSize.height * .03),
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
                fontSize: screenSize.width * .041,
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
