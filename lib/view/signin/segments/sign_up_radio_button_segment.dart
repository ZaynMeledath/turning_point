import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_radio_button.dart';

Widget signUpRadioButtonSegment({
  required String title,
  required bool isActive,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .01),
    child: Row(
      children: [
        customRadioButton(isActive: isActive),
        SizedBox(width: screenSize.width * .051),
        Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .034,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}
