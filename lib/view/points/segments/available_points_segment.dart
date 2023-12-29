import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:turning_point/helper/custom_navigator.dart';
import 'package:turning_point/view/redeem/redeem_screen.dart';

Widget availablePointsSegment({
  required Size screenSize,
  required BuildContext context,
}) {
  return Column(
    children: [
//====================Available Points Segment====================//
      Text(
        'Available Points',
        style: GoogleFonts.roboto(
          fontSize: screenSize.width * .035,
          fontWeight: FontWeight.w500,
          color: const Color.fromRGBO(255, 167, 37, 1),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '10000',
            style: GoogleFonts.roboto(
              fontSize: screenSize.width * .127,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 2),
          Column(
            children: [
              SizedBox(height: screenSize.width * .034),
              Image.asset(
                'assets/icons/coin_stack_icon.png',
                width: screenSize.width * .052,
              ),
            ],
          )
        ],
      ),
      GestureDetector(
        onTap: () => CustomNavigator.push(
          context: context,
          child: const RedeemScreen(),
        ),
        child: Container(
          width: screenSize.width * .16,
          height: screenSize.width * .055,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromRGBO(255, 215, 0, 1),
                Color.fromRGBO(255, 238, 141, 1),
              ],
            ),
          ),
          child: Center(
            child: Text(
              'Redeem',
              style: GoogleFonts.roboto(
                color: Colors.black.withOpacity(.9),
                fontSize: screenSize.width * .026,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: screenSize.height * .028),

//====================Reward Points Segment====================//
      Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * .051),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/icons/reward_points_icon.png',
              width: screenSize.width * .24,
            ),
            SizedBox(width: screenSize.width * .02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Text(
                      'Reward Points',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .051,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Text(
                      'You have 80 Points!',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .035,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height * .017),

//====================Linear Percent Indicator====================//
                LinearPercentIndicator(
                  backgroundColor: const Color.fromRGBO(254, 241, 218, 1),
                  progressColor: const Color.fromRGBO(252, 190, 74, 1),
                  percent: .8,
                  width: screenSize.width * .49,
                  lineHeight: 10,
                  barRadius: const Radius.circular(8.5),
                  trailing: Text(
                    '80/100',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .031,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ],
  );
}
