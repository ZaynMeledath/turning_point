import 'package:flutter/material.dart';
import 'package:turning_point/utils/screen_size.dart';

//====================For The First Three Prizes====================//
Widget roundPrizeContainer({
  required String imagePath,
  required String medalPath,
  required Color backgroundColor,
  required Color shadowColor,
}) {
  return SizedBox(
    width: screenSize.width * .25,
    height: screenSize.width * .256,
    child: Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
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
        ),
        // Positioned(
        //   child: Container(
        //     width: screenSize.width * .232,
        //     decoration: BoxDecoration(
        //       color: Colors.transparent,
        //       shape: BoxShape.circle,
        //       border: Border.all(
        //         color: Colors.white,
        //         width: 2,
        //       ),
        //     ),
        //   ),
        // ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset(
            medalPath,
            width: screenSize.width * .09,
          ),
        ),
      ],
    ),
  );
}
