import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/contest/segments/contest_card_inner_container.dart';
import 'package:turning_point/view/contest/segments/contest_count_down_container.dart';

Widget contestCard({required BuildContext context}) {
  return Container(
    width: double.infinity,
    height: screenSize.height * .32,
    margin: EdgeInsets.symmetric(horizontal: screenSize.width * .055),
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
        contestCardInnerContainer(context: context),
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
            SizedBox(width: screenSize.width * .021),
            contestCountDownContainer(time: '03', title: 'HOURS'),
            SizedBox(width: screenSize.width * .021),
            contestCountDownContainer(time: '03', title: 'MINUTES'),
            SizedBox(width: screenSize.width * .021),
            contestCountDownContainer(time: '03', title: 'SECONDS'),
          ],
        )
      ],
    ),
  );
}
