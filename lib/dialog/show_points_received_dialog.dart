import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';

showPointsReceivedToast({
  required BuildContext context,
  required int points,
}) {
  final flutterToast = FToast();
  flutterToast.init(context);

  flutterToast.showToast(
    gravity: ToastGravity.TOP,
    child: dialog(points: points),
  );
}

Widget dialog({
  required int points,
}) {
  return Container(
    width: screenSize.width * .48,
    padding: EdgeInsets.symmetric(vertical: screenSize.width * .021),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      children: [
        SizedBox(width: screenSize.width * .02),
        Image.asset(
          'assets/images/points_received_dialog_image.png',
          width: screenSize.width * .07,
        ),
        SizedBox(width: screenSize.width * .02),
        DefaultTextStyle(
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .04,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          child: Text(
            '$points Points Credited',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
