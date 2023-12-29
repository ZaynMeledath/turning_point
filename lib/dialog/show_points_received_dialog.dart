import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';

Future<Object?> showPointsReceivedDialog({
  required BuildContext context,
}) async {
  return showGeneralDialog(
    context: context,
    pageBuilder: (context, a1, a2) {
      return Container();
    },
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (context, a1, a2, child) {
      final curve = Curves.easeInOut.transform(a1.value);
      return Transform.scale(
        scale: curve,
        child: dialog(context),
      );
    },
  );
}

Widget dialog(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: screenSize.width * .071,
      vertical: screenSize.height * .31,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      children: [
        SizedBox(height: screenSize.height * .025),
        Image.asset(
          'assets/images/points_received_dialog_image.png',
          width: screenSize.width * .20,
        ),
        SizedBox(height: screenSize.height * .021),
        DefaultTextStyle(
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .061,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          child: const Text(
            'Congratulations!!',
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: screenSize.height * .012),
        DefaultTextStyle(
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .061,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          child: const Text(
            '25 Points Successfully\nReceived',
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: screenSize.height * .05),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: screenSize.width * .2,
            height: screenSize.width * .094,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromRGBO(0, 99, 255, 1),
            ),
            child: DefaultTextStyle(
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .061,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              child: const Center(
                child: Text(
                  'OK',
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
