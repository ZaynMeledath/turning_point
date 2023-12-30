import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';

Widget dashboardActivityContainer({
  required String title,
  required String won,
  required String participated,
  required String imagePath,
  required double imageHeight,
  required List<Color> imageContainerGradient,
}) {
  return Container(
    width: screenSize.height * .186,
    height: screenSize.height * .186,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          blurRadius: 1,
          color: Colors.black.withOpacity(.15),
          blurStyle: BlurStyle.outer,
        ),
        BoxShadow(
          offset: const Offset(0, 1),
          blurRadius: 4,
          color: Colors.black.withOpacity(.15),
          blurStyle: BlurStyle.outer,
        ),
      ],
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: screenSize.height * .013,
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: screenSize.width * .026,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          width: screenSize.height * .107,
          height: screenSize.height * .107,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: imageContainerGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Image.asset(
              imagePath,
              height: imageHeight,
            ),
          ),
        ),
        Positioned(
          bottom: screenSize.height * .005,
          left: screenSize.height * .014,
          child: Text(
            won,
            style: GoogleFonts.roboto(
              fontSize: screenSize.width * .051,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Positioned(
          bottom: screenSize.height * .011,
          right: screenSize.height * .014,
          child: Text(
            'Participated: $participated',
            style: GoogleFonts.roboto(
              fontSize: screenSize.width * .02,
              fontWeight: FontWeight.w600,
              color: const Color.fromRGBO(72, 72, 72, 1),
            ),
          ),
        ),
      ],
    ),
  );
}
