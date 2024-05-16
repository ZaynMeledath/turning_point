import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/utils/screen_size.dart';

Widget boardingScreenContent({
  required String title,
  required String imagePath,
  required double imageWidth,
  required String content,
  required int activePageNumber,
  double? imageSpacing,
  double? contentSpacing,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .051),
    child: Column(
      crossAxisAlignment: activePageNumber == 3
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        SizedBox(height: imageSpacing ?? 0),
        SizedBox(height: screenSize.height * .15),

//====================Illustration====================//
        Center(
          child: Image.asset(
            imagePath,
            width: imageWidth,
          ),
        ),
        SizedBox(
          height: activePageNumber == 3
              ? screenSize.height * .05
              : screenSize.height * .06,
        ),

//====================Boarding Title====================//
        Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .091,
            fontWeight: FontWeight.w700,
            color: const Color.fromRGBO(0, 0, 0, 1),
          ),
        ),
        SizedBox(height: contentSpacing ?? screenSize.height * .012),

//====================Boarding Content====================//
        Text(
          content,
          style: GoogleFonts.roboto(
            height: 1.5,
            fontSize: screenSize.width * .036,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}
