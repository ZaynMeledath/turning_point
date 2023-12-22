import 'package:flutter/material.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/lucky_draw/segments/gift_box_container.dart';

Widget giftBoxesSegment() {
  return Column(
    children: [
      Row(
        children: [
          giftBoxContainer(),
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
