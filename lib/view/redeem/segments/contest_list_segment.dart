import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/model/contest_model.dart';

Widget contestListSegment({
  required ContestModel contestModel,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15, top: 5),
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .026),
    height: screenSize.height * .067,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          offset: const Offset(1, 1),
          blurRadius: 2,
          color: Colors.black.withOpacity(.07),
        ),
        BoxShadow(
          offset: const Offset(-1, -1),
          blurRadius: 2,
          color: Colors.black.withOpacity(.07),
        ),
      ],
    ),
    child: Row(
      children: [
//====================Trailing Points Transaction Amount Container====================//
        Container(
          height: screenSize.height * .03,
          padding: const EdgeInsets.only(
            left: 2,
            right: 6,
            top: 2,
            bottom: 2,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromRGBO(255, 215, 0, 1),
                Color.fromRGBO(255, 238, 141, 1),
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'assets/icons/coin_icon.png',
                width: 29,
              ),
              Text(
                'price',
                style: GoogleFonts.inter(
                  fontSize: screenSize.width * .031,
                  fontWeight: FontWeight.w800,
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
