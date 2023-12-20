import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/view/rewards/segments/round_prize_container.dart';

Widget mainPrizeSegment({required Size screenSize}) {
  return Stack(
    alignment: Alignment.topCenter,
    children: [
//====================First Prize Segment====================//
      Positioned(
        top: screenSize.height * .17,
        child: Column(
          children: [
            Text(
              '1st Prize',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: screenSize.width * .031,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: screenSize.height * .01),
            roundPrizeContainer(
              screenSize: screenSize,
              imagePath: 'assets/images/bike_image.png',
              backgroundColor: const Color.fromRGBO(255, 219, 73, 1),
              shadowColor: const Color.fromRGBO(206, 166, 4, 1),
            ),
            SizedBox(height: screenSize.height * .01),
            CircleAvatar(
              radius: screenSize.width * .044,
              backgroundImage: const AssetImage('assets/images/avatar.jpg'),
            ),
            Text(
              'Eva Allen',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .031,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              '100,000 Pts',
              style: GoogleFonts.roboto(
                color: const Color.fromRGBO(246, 147, 0, 1),
                fontSize: screenSize.width * .032,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),

//====================Second Prize Segment====================//
      Positioned(
        top: screenSize.height * .34,
        left: screenSize.width * .051,
        child: Column(
          children: [
            Text(
              '2nd Prize',
              style: GoogleFonts.poppins(
                fontSize: screenSize.width * .031,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: screenSize.height * .01),
            roundPrizeContainer(
              screenSize: screenSize,
              imagePath: 'assets/images/bike_image.png',
              backgroundColor: const Color.fromRGBO(255, 50, 56, 1),
              shadowColor: const Color.fromRGBO(173, 0, 2, 1),
            ),
            SizedBox(height: screenSize.height * .01),
            CircleAvatar(
              radius: screenSize.width * .044,
              backgroundImage: const AssetImage('assets/images/avatar.jpg'),
            ),
            Text(
              'Eva Allen',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .031,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              '100,000 Pts',
              style: GoogleFonts.roboto(
                color: const Color.fromRGBO(246, 147, 0, 1),
                fontSize: screenSize.width * .032,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),

//====================Third Prize Segment====================//
      Positioned(
        top: screenSize.height * .34,
        right: screenSize.width * .051,
        child: Column(
          children: [
            Text(
              '3rd Prize',
              style: GoogleFonts.poppins(
                fontSize: screenSize.width * .031,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: screenSize.height * .01),
            roundPrizeContainer(
              screenSize: screenSize,
              imagePath: 'assets/images/bike_image.png',
              backgroundColor: const Color.fromRGBO(23, 195, 196, 1),
              shadowColor: const Color.fromRGBO(0, 151, 152, 1),
            ),
            SizedBox(height: screenSize.height * .01),
            CircleAvatar(
              radius: screenSize.width * .044,
              backgroundImage: const AssetImage('assets/images/avatar.jpg'),
            ),
            Text(
              'Eva Allen',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .031,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              '100,000 Pts',
              style: GoogleFonts.roboto(
                color: const Color.fromRGBO(246, 147, 0, 1),
                fontSize: screenSize.width * .032,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
