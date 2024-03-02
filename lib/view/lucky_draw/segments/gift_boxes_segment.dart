import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/lucky_draw/segments/gift_box_container.dart';

//====================Whole Gift Box Segment in Lucky Draw Screen====================//
Widget giftBoxesSegment() {
  return Column(
    children: [
      Row(
        children: [
          GestureDetector(
              // onTap: () => ,
              child: giftBoxContainer()),
          SizedBox(width: screenSize.width * .08),
          giftBoxContainer(),
          SizedBox(width: screenSize.width * .08),
          giftBoxContainer(),
        ],
      ),
      SizedBox(height: screenSize.height * .019),
      Row(
        children: [
          giftBoxContainer(),
          SizedBox(width: screenSize.width * .08),
          giftBoxContainer(),
          SizedBox(width: screenSize.width * .08),
          giftBoxContainer(),
        ],
      ),
    ],
  );
}
