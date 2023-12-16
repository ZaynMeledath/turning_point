import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget kycPageTitle({
  required Size screenSize,
  required String title,
  required String titleNumber,
  required bool isDoneOrActive,
}) {
  return Column(
    children: [
      Container(
        width: screenSize.width * .042,
        height: screenSize.width * .042,
        decoration: BoxDecoration(
          color: isDoneOrActive
              ? const Color.fromRGBO(0, 189, 190, 1)
              : Colors.white,
          borderRadius: BorderRadius.circular(100),
          border: !isDoneOrActive
              ? Border.all(
                  color: const Color.fromRGBO(0, 189, 190, 1),
                )
              : null,
        ),
        child: Center(
          child: Text(
            titleNumber,
            style: GoogleFonts.roboto(
              color: isDoneOrActive
                  ? Colors.white
                  : const Color.fromRGBO(0, 189, 190, 1),
              fontSize: screenSize.width * .031,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
      SizedBox(height: screenSize.height * .008),
      Text(
        title,
        style: GoogleFonts.roboto(
          fontSize: screenSize.width * .026,
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}
