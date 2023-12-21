import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';

Widget contestCountDownContainer({
  required String time,
  required String title,
}) {
  return Container(
    width: screenSize.width * .087,
    height: screenSize.width * .1,
    decoration: const BoxDecoration(
        color: Color.fromRGBO(236, 236, 236, 1),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 3,
            color: Color.fromRGBO(121, 121, 121, 0.25),
            blurStyle: BlurStyle.inner,
          ),
        ]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(),
            child: Center(
              child: Text(
                time,
                style: GoogleFonts.roboto(
                  fontSize: screenSize.width * .05,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: screenSize.width * .029,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .016,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
