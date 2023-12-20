import 'package:flutter/material.dart';
import 'package:turning_point/helper/screen_size.dart';

Widget giftBoxContainer() {
  return Container(
    width: screenSize.width * .24,
    height: screenSize.width * .24,
    padding: EdgeInsets.all(screenSize.width * .02),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: const [
        BoxShadow(
          offset: Offset(0, 2),
          blurRadius: 4,
          color: Color.fromRGBO(0, 0, 0, .22),
        ),
      ],
    ),
    child: Image.asset('assets/images/red_gift_box.png'),
  );
}
