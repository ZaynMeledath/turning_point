import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';

Widget contestHeading() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .051),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'CONTESTS',
          style: GoogleFonts.poppins(
            fontSize: screenSize.width * .051,
            fontWeight: FontWeight.w700,
            color: const Color.fromRGBO(83, 83, 83, 1),
          ),
        ),
      ],
    ),
  );
}
