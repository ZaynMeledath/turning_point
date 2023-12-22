import 'package:flutter/material.dart';

Widget customRadioButton({required Size screenSize, required bool isActive}) {
  return isActive
      ? Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: screenSize.width * .035,
              height: screenSize.width * .035,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 226, 226),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            Container(
              width: screenSize.width * .03,
              height: screenSize.width * .03,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 189, 190, 1),
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



// Color.fromRGBO(255, 0, 0, 0.3)
// Color.fromRGBO(225, 40, 38, 1),