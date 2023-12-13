import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget kycPageTitle({
  required Size screenSize,
  required String title,
  required bool isDoneOrActive,
}) {
  return Column(
    children: [
      Text(
        title,
        style: GoogleFonts.roboto(
          fontSize: screenSize.width * .031,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: screenSize.height * .008),
      Container(
        width: screenSize.width * .256,
        height: screenSize.height * .007,
        decoration: BoxDecoration(
          color: isDoneOrActive
              ? const Color.fromRGBO(226, 61, 62, 1)
              : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: !isDoneOrActive
              ? Border.all(
                  color: const Color.fromRGBO(83, 83, 83, 1),
                )
              : null,
        ),
      ),
    ],
  );
}
