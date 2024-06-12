import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//====================Styling of Individual options in profile screen====================//
Widget profileOption({
  required Size screenSize,
  required String iconPath,
  required String title,
  required Color containerColor,
  double? containerPadding,
}) {
  return Container(
    padding: EdgeInsets.only(
      left: screenSize.width * .046,
      right: screenSize.width * .046,
      bottom: screenSize.height * .031,
    ),
    color: Colors.transparent,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: screenSize.width * .072,
              height: screenSize.width * .072,
              padding:
                  EdgeInsets.all(containerPadding ?? screenSize.width * .013),
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                iconPath,
              ),
            ),
            SizedBox(width: screenSize.width * .03),
            Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .041,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Icon(
          Icons.arrow_forward_ios,
          size: screenSize.width * .045,
          color: const Color(0xff8E8E8E),
        )
      ],
    ),
  );
}
