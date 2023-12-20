import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';

Widget customAppBar({
  required BuildContext context,
  required String title,
  Color? backgroundColor,
  Color? foregroundColor,
}) {
  return Column(
    children: [
      SizedBox(height: screenSize.height * .007),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * .03),
        child: Row(
          children: [
            Hero(
              tag: 'back_button',
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: screenSize.width * .054,
                  color: foregroundColor,
                ),
                onPressed: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(width: screenSize.width * .041),
            Hero(
              tag: title,
              child: Text(
                title,
                style: GoogleFonts.inter(
                  color: foregroundColor,
                  fontSize: screenSize.width * .041,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      )
    ],
  );
}
