import 'package:flutter/material.dart';
import 'package:turning_point/helper/screen_size.dart';

//====================For The First Three Prizes====================//
Widget roundPrizeContainer({
  required String imagePath,
  required Color backgroundColor,
  required Color shadowColor,
}) {
  return CircleAvatar(
    radius: screenSize.width * .12,
    backgroundColor: backgroundColor,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: screenSize.width * .246,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: shadowColor),
              BoxShadow(
                spreadRadius: -18,
                blurRadius: 20,
                color: backgroundColor,
              )
            ],
          ),
          // child: Image.network(imagePath),
        ),
        Image.network(
          imagePath,
          width: screenSize.width * .18,
        )
      ],
    ),
  );
}
