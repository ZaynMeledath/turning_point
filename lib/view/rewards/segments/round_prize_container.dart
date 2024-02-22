import 'package:flutter/material.dart';

//====================For The First Three Prizes====================//
Widget roundPrizeContainer({
  required Size screenSize,
  required String imagePath,
  required Color backgroundColor,
  required Color shadowColor,
}) {
  return CircleAvatar(
    radius: screenSize.width * .13,
    backgroundColor: backgroundColor,
    // backgroundImage: AssetImage(imagePath),
    child: Container(
      width: screenSize.width * .246,
      decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
        BoxShadow(color: shadowColor),
        BoxShadow(
          spreadRadius: -18,
          blurRadius: 20,
          color: backgroundColor,
        )
      ]),
      child: Image.asset(imagePath),
    ),
  );
}
