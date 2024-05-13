import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/utilities/screen_size.dart';

Widget whoIsSigningContainer({
  required String title,
  required String imagePath,
}) {
  return SizedBox(
    width: screenSize.width * .36,
    height: screenSize.width * .18,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: screenSize.width * .36,
          height: screenSize.width * .115,
          padding: EdgeInsets.only(right: screenSize.width * .028),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(255, 255, 255, .2),
                Color.fromRGBO(255, 255, 255, .15),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              title,
              style: GoogleFonts.openSans(
                fontSize: screenSize.width * .032,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          child: CircleAvatar(
            radius: screenSize.width * .075,
            backgroundColor: Colors.black.withOpacity(.8),
            child: CircleAvatar(
              radius: screenSize.width * .075 - 4,
              backgroundImage: AssetImage(imagePath),
            ),
          ),
        ),
      ],
    ),
  );
}
