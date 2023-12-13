import 'package:flutter/material.dart';
import 'package:turning_point/controller/points_provider.dart';
import 'package:turning_point/view/points/segments/point_container.dart';

//====================Points History Segment====================//
Widget pointsHistorySegment({required Size screenSize}) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.only(
        top: screenSize.height * .025,
        left: screenSize.width * .038,
        right: screenSize.width * .038,
      ),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(245, 246, 250, 1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: ListView.builder(
        itemCount: 10,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return pointContainer(
            screenSize: screenSize,
            isCredited: pointsHistory[index],
          );
        },
      ),
    ),
  );
}
