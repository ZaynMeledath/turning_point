import 'package:flutter/material.dart';
import 'package:turning_point/utils/screen_size.dart';

Widget customRadioButton({required bool isActive}) {
  return isActive
      ? Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: screenSize.width * .035,
              height: screenSize.width * .035,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 161, 255, 1),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            Container(
              width: screenSize.width * .03,
              height: screenSize.width * .03,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 99, 255, 1),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            Container(
              width: screenSize.width * .013,
              height: screenSize.width * .013,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ],
        )
      : Container(
          width: screenSize.width * .035,
          height: screenSize.width * .035,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: Colors.black.withOpacity(.5),
            ),
          ),
        );
}
