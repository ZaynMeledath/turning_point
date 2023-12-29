import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/custom_navigator.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/redeem/redeem_screen.dart';

Widget dashboardAvailableBalanceContainer({required BuildContext context}) {
  return Container(
    width: double.infinity,
    height: screenSize.height * .16,
    padding: EdgeInsets.symmetric(
      horizontal: screenSize.width * .04,
      vertical: screenSize.width * .038,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.blueGrey.withOpacity(.1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Available Balance',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .03,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              'Win Rate 80%',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .03,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Text(
          '10000',
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .09,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                CustomNavigator.push(
                  context: context,
                  child: const RedeemScreen(),
                );
              },
              child: Container(
                width: screenSize.width * .15,
                height: screenSize.width * .052,
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
                      fontSize: screenSize.width * .024,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              'Total Contests Participated : 20',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .03,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
