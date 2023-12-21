import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/contest/segments/contest_count_down_container.dart';

Widget contestCard() {
  return Container(
    width: double.infinity,
    height: screenSize.height * .32,
    margin: EdgeInsets.symmetric(horizontal: screenSize.width * .051),
    decoration: const BoxDecoration(
      color: Color.fromRGBO(255, 255, 255, 1),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 4),
          color: Color.fromRGBO(0, 0, 0, 0.25),
          blurRadius: 4,
          blurStyle: BlurStyle.outer,
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          height: screenSize.height * .216,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(255, 245, 188, .5),
                Color.fromRGBO(255, 245, 188, 1),
              ],
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 1.8,
                color: Color.fromRGBO(0, 0, 0, .25),
                blurStyle: BlurStyle.outer,
              ),
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 50,
                color: Color.fromRGBO(255, 196, 109, 1),
                blurStyle: BlurStyle.inner,
              ),
            ],
          ),
        ),
        SizedBox(height: screenSize.height * .01),
        Text(
          'Time Left',
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .03,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: screenSize.height * .007),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            contestCountDownContainer(time: '03', title: 'DAYS'),
            SizedBox(width: screenSize.width * .031),
            contestCountDownContainer(time: '03', title: 'HOURS'),
            SizedBox(width: screenSize.width * .031),
            contestCountDownContainer(time: '03', title: 'MINUTES'),
            SizedBox(width: screenSize.width * .031),
            contestCountDownContainer(time: '03', title: 'SECONDS'),
          ],
        )
      ],
    ),
  );
}
