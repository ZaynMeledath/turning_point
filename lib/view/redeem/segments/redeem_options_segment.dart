import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget redeemOptionsSegment({required Size screenSize}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * .041,
              vertical: screenSize.width * .019,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color.fromRGBO(0, 99, 255, 1),
            ),
            child: Text(
              'Buy Coupons',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .033,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: screenSize.width * .025),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * .041,
              vertical: screenSize.width * .019,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color.fromRGBO(218, 218, 218, 1),
              ),
            ),
            child: Text(
              'Direct Bank Transfer',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .033,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: screenSize.height * .019),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * .041,
              vertical: screenSize.width * .019,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color.fromRGBO(218, 218, 218, 1),
              ),
            ),
            child: Text(
              'In-App Purchase',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .033,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: screenSize.width * .025),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * .041,
              vertical: screenSize.width * .019,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color.fromRGBO(218, 218, 218, 1),
              ),
            ),
            child: Text(
              'UPI Transfer',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .033,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
