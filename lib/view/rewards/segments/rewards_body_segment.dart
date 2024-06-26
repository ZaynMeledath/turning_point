import 'package:flutter/material.dart';
import 'package:turning_point/utils/screen_size.dart';
import 'package:turning_point/model/rewards_model.dart';
import 'package:turning_point/view/rewards/segments/clipper_widget.dart';
import 'package:turning_point/view/rewards/segments/main_prize_segment.dart';

Widget rewardsBodySegment({RewardsModel? rewardsModel}) {
  return Stack(
    alignment: Alignment.topCenter,
    children: [
//====================Yellow Linear Gradient Container under Red Container====================//
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

//====================Red Container====================//
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
//====================Coins image on red container====================//
          child: Image.asset(
            'assets/images/coins_rain.png',
            fit: BoxFit.cover,
          ),
        ),
      ),

//====================Body Segment====================//
      mainPrizeSegment(rewards: rewardsModel),
    ],
  );
}
