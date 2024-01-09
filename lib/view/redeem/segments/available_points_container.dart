import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget availablePointsContainer({required Size screenSize}) {
  return Container(
    width: double.infinity,
    height: screenSize.width * .33,
    margin: EdgeInsets.only(
      left: screenSize.width * .07,
      right: screenSize.width * .07,
      top: screenSize.height * .02,
    ),
    padding: EdgeInsets.all(screenSize.width * .025),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(.8),
      borderRadius: BorderRadius.circular(21),
      boxShadow: [
        BoxShadow(
          offset: const Offset(0, 3),
          color: Colors.black.withOpacity(.1),
          blurRadius: 4,
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CircleAvatar(
          foregroundImage: AssetImage('assets/images/avatar.jpg'),
        ),
        Text(
          'Available Points to Redeem',
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .028,
            color: const Color.fromRGBO(123, 123, 123, 1),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '10000',
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .092,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
