import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/dashboard/segments/contests_clipper.dart';

Widget contestsParticipatedContainer() {
  return ClipPath(
    clipper: ContestsClipper(),
    child: Container(
      width: screenSize.width * .42,
      height: screenSize.width * .3,
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * .033,
        vertical: screenSize.width * .03,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromRGBO(246, 227, 255, 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: screenSize.width * .01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/contest_icon.png',
                width: screenSize.width * .055,
              ),
              SizedBox(width: screenSize.width * .01),
              Text(
                'Contests',
                style: GoogleFonts.roboto(
                  fontSize: screenSize.width * .031,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: screenSize.width * .01),
          const DottedLine(
            alignment: WrapAlignment.center,
            direction: Axis.horizontal,
            dashColor: Colors.white,
            dashLength: 2,
            dashGapLength: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    '20',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .041,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Participated',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .03,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(width: screenSize.width * .1),
              Column(
                children: [
                  Text(
                    '16',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .041,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Win',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .03,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}
