import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';

Widget boardingScreenContent({
  required String title,
  required String imagePath,
  required double imageWidth,
  required String content,
  String subTitle = '',
  double? imageSpacing,
}) {
  return Column(
    children: [
      SizedBox(height: imageSpacing),
      SizedBox(height: screenSize.height * .16),
      Image.asset(
        imagePath,
        width: imageWidth,
      ),
      SizedBox(height: screenSize.height * .04),
      Text(
        title,
        style: GoogleFonts.roboto(
          fontSize: screenSize.width * .061,
          fontWeight: FontWeight.w700,
          color: const Color.fromRGBO(24, 29, 61, 1),
        ),
      ),
      subTitle.isNotEmpty
          ? Text(
              subTitle,
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .051,
                fontWeight: FontWeight.w600,
                color: const Color.fromRGBO(24, 29, 61, 1),
              ),
            )
          : const SizedBox(height: 0),
      SizedBox(height: screenSize.height * .012),
      Text(
        content,
        textAlign: TextAlign.center,
        style: GoogleFonts.roboto(
          height: 1.5,
          fontSize: screenSize.width * .031,
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}
