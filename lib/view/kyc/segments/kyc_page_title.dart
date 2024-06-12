import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/utils/screen_size.dart';

Widget kycPageTitle({
  required String title,
  required String titleNumber,
  required bool isDoneOrActive,
}) {
  return Column(
    children: [
      Container(
        width: realScreenSize.width * .042,
        height: realScreenSize.width * .042,
        decoration: BoxDecoration(
          color: isDoneOrActive
              ? const Color.fromRGBO(0, 99, 255, 1)
              : Colors.white,
          borderRadius: BorderRadius.circular(100),
          border: !isDoneOrActive
              ? Border.all(
                  color: const Color.fromRGBO(0, 99, 255, 1),
                )
              : null,
        ),
        child: Center(
          child: Text(
            titleNumber,
            style: GoogleFonts.roboto(
              color: isDoneOrActive
                  ? Colors.white
                  : const Color.fromRGBO(0, 99, 255, 1),
              fontSize: screenSize.width * .028,
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
