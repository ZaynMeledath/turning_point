import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';

Widget bannerSegment() {
  return Column(
    children: [
      Container(
        width: double.infinity,
        height: screenSize.height * .19,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * .061),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'PLAY AND EARN',
                    style: GoogleFonts.poppins(
                      fontSize: screenSize.width * .051,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Earn Prize by participating in\nContests',
                    style: GoogleFonts.poppins(
                      color: const Color.fromRGBO(0, 90, 143, 1),
                      fontSize: screenSize.width * .038,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    width: screenSize.width * .194,
                    height: screenSize.width * .066,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromRGBO(0, 99, 255, 1),
                    ),
                    child: Center(
                      child: Text(
                        'Play Now',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: screenSize.width * .03,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: -4,
              bottom: 0,
              child: Image.asset(
                'assets/images/contest_banner_image.png',
                width: screenSize.width * .5,
              ),
            )
          ],
        ),
      ),
      SizedBox(height: screenSize.height * .01),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Available Points : ',
            style: GoogleFonts.roboto(
              color: const Color.fromRGBO(0, 99, 255, 1),
              fontSize: screenSize.width * .03,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '10000',
            style: GoogleFonts.roboto(
              color: const Color.fromRGBO(255, 152, 0, 1),
              fontSize: screenSize.width * .032,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ],
  );
}
