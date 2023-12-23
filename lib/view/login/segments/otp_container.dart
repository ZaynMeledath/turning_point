import 'package:flutter/material.dart';
import 'package:turning_point/helper/screen_size.dart';

Widget otpContainer() {
  return Container(
    width: screenSize.width * .09,
    height: screenSize.width * .09,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      border: Border.all(
        color: const Color.fromRGBO(155, 155, 155, 1),
      ),
    ),
  );
}
