import 'package:flutter/material.dart';
import 'package:turning_point/view/rewards/segments/clipper_widget.dart';
import 'package:turning_point/view/rewards/segments/main_prize_segment.dart';

Widget rewardsBodySegment({required Size screenSize}) {
  return Stack(
    alignment: Alignment.topCenter,
    children: [
      Container(
        height: screenSize.height * .34,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 244, 163, 1),
              Color.fromRGBO(255, 235, 80, 0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      ClipPath(
        clipper: ClipperWidget(),
        child: Container(
          width: double.infinity,
          height: screenSize.height * .313,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(175, 19, 20, 1),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -20),
                blurRadius: 23,
                color: Color.fromRGBO(175, 0, 2, 1),
              ),
              BoxShadow(
                offset: Offset(0, 25),
                blurRadius: 123,
                color: Color.fromRGBO(0, 0, 0, .25),
              ),
            ],
          ),
          child: Image.asset(
            'assets/images/coins_rain.png',
            fit: BoxFit.cover,
          ),
        ),
      ),

//====================Body Segment====================//
      mainPrizeSegment(screenSize: screenSize),
    ],
  );
}
