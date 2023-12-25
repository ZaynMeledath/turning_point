import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';

Widget titleContentText({
  required bool isTitle,
  required String text,
}) {
  if (isTitle) {
    return Column(
      children: [
        SizedBox(height: screenSize.height * .02),
        Text(
          text,
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .03,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
      ],
    );
  } else {
    return Column(
      children: [
        SizedBox(height: screenSize.height * .01),
        Text(
          text,
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .028,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
