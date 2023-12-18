import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customAppBar({
  required BuildContext context,
  required Size screenSize,
  required String title,
  Color? backgroundColor,
}) {
  return Column(
    children: [
      SizedBox(height: screenSize.height * .009),
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
