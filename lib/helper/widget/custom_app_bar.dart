import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/flight_shuttle.dart';
import 'package:turning_point/helper/screen_size.dart';

Widget customAppBar({
  required BuildContext context,
  required String title,
  Color? backgroundColor,
  Color? foregroundColor,
  bool implyLeading = true,
}) {
  return Column(
    children: [
      SizedBox(height: screenSize.height * .007),
      Row(
        children: [
          Visibility(
            visible: implyLeading,
            child: Hero(
              tag: 'back_button',
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: screenSize.width * .061,
                  color: foregroundColor,
                ),
                onPressed: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          SizedBox(width: screenSize.width * .041),
          Hero(
            tag: title,
            flightShuttleBuilder: flightShuttleBuilder,
            child: Text(
              title,
              style: GoogleFonts.inter(
                color: foregroundColor,
                fontSize: screenSize.width * .041,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      )
    ],
  );
}
