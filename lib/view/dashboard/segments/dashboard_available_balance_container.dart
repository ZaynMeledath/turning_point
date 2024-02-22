import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/custom_navigator.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/model/user_model.dart';
import 'package:turning_point/view/redeem/redeem_screen.dart';

Widget dashboardAvailableBalanceContainer({
  required BuildContext context,
  required UserModel userModel,
}) {
  int winRate = 0;
  if (userModel.contestsParticipatedInCount != 0) {
    winRate = (userModel.contestUniqueWonCount! /
            userModel.contestsParticipatedInCount! *
            100)
        .toInt();
  }

  return Container(
    width: double.infinity,
    height: screenSize.height * .15,
    padding: EdgeInsets.symmetric(
      horizontal: screenSize.width * .04,
      vertical: screenSize.width * .034,
    ),
    margin: EdgeInsets.only(
      left: screenSize.width * .05,
      right: screenSize.width * .05,
      top: screenSize.width * .66,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          blurRadius: 4,
          color: Colors.black.withOpacity(.25),
          blurStyle: BlurStyle.outer,
        ),
      ],
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
              'Win Rate $winRate%',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .03,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Text(
          userModel.points!.toString(),
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .09,
            fontWeight: FontWeight.w600,
            color: const Color.fromRGBO(255, 176, 53, 1),
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
                      fontSize: screenSize.width * .024,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              'Total Contests Participated : ${userModel.contestsParticipatedInCount}',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .03,
                fontWeight: FontWeight.w600,
                color: const Color.fromRGBO(78, 78, 78, 1),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
