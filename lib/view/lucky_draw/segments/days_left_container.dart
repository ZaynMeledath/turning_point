import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';

Widget daysLeftContainer({
  required String daysLeft,
}) {
  return Container(
    width: screenSize.width * .31,
    height: screenSize.width * .092,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color.fromRGBO(86, 190, 240, 1),
          Color.fromRGBO(54, 132, 199, 1),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(25),
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(5, 102, 173, 1),
          offset: Offset(0, 2),
          blurRadius: 1.3,
          blurStyle: BlurStyle.inner,
        ),
      ],
    ),
    child: Center(
      child: Text(
        '$daysLeft Days Left',
        style: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: screenSize.width * .041,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
