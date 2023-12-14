import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget kycIdCaptureContainer({
  required Size screenSize,
  required String title,
  required bool isActive,
}) {
  return Container(
    width: screenSize.width * .36,
    height: screenSize.width * .12,
    decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [
        Color.fromRGBO(184, 184, 184, .2),
        Color.fromRGBO(239, 239, 239, .3),
        Color.fromRGBO(184, 184, 184, .2),
      ]),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.camera_alt,
          color:
              isActive ? Colors.black : const Color.fromRGBO(215, 215, 215, 1),
        ),
        SizedBox(width: screenSize.width * .012),
        Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .036,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}
