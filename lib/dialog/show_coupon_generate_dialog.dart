import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';

Future<Object?> showCouponGenerateDialog({
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
        child: dialog(),
      );
    },
  );
}

Widget dialog() {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: screenSize.width * .25,
      vertical: screenSize.height * .36,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(9),
    ),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: screenSize.width * .22,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(9),
              topLeft: Radius.circular(9),
            ),
            color: Color.fromRGBO(253, 215, 54, 1),
          ),
        ),
        Positioned(
          top: (screenSize.width * .22) - (screenSize.width * .3 / 2),
          child: Container(
            width: screenSize.width * .3,
            height: screenSize.width * .3,
            padding: EdgeInsets.all(screenSize.width * .041),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: Colors.white,
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(screenSize.width * .025),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 2),
                      blurRadius: .3,
                      color: Colors.black.withOpacity(.06),
                    )
                  ],
                ),
                child: Center(
                  child: AnimatedRotation(
                    turns: 10,
                    duration: const Duration(seconds: 2),
                    child: Image.asset(
                      'assets/icons/percentage_icon.png',
                      width: screenSize.width * .046,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          child: Text(
            'Generating...',
            style: GoogleFonts.roboto(
              decoration: TextDecoration.none,
              color: Colors.black,
              fontSize: screenSize.width * .036,
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    ),
  );
}
