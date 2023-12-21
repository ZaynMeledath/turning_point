import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';

Widget contestHeading() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .051),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'CONTESTS',
          style: GoogleFonts.poppins(
            fontSize: screenSize.width * .051,
            fontWeight: FontWeight.w700,
            color: const Color.fromRGBO(83, 83, 83, 1),
          ),
        ),
        Text(
          'View All',
          style: GoogleFonts.poppins(
            fontSize: screenSize.width * .031,
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(83, 83, 83, 1),
          ),
        ),
      ],
    ),
  );
}
