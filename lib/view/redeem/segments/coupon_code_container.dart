import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';

// void _copyToClipboard(String text) {
//   Clipboard.setData(ClipboardData(text: text));
// }

Widget couponCodeContainer({
  required BuildContext context,
  required String couponCode,
}) {
  return Container(
    width: screenSize.width * .8,
    height: screenSize.height * .09,
    color: Colors.black,
    child: CustomPaint(
      painter: StepsPainter(),
      child: Row(
        children: [
          SizedBox(width: screenSize.width * .06),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Coupon Code',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: screenSize.width * .03,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                couponCode,
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: screenSize.width * .05,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const Expanded(
            child: SizedBox(),
          ),
          const VerticalDivider(
            color: Colors.white,
            indent: 10,
            endIndent: 10,
          ),
          SizedBox(width: screenSize.width * .03),
          GestureDetector(
            onTap: () {
              // _copyToClipboard(couponCode);
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(
              //       content: Text('Coupon code copied to clipboard!')),
              // );
            },
            child: Text(
              'Copy Code',
              style: GoogleFonts.roboto(
                color: const Color(0xffffa500),
                fontSize: screenSize.width * .035,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: screenSize.width * .042)
        ],
      ),
    ),
  );
}

class StepsPainter extends CustomPainter {
  final int numberOfStepsHorizontal =
      28; // Number of horizontal rectangular steps
  final int numberOfStepsVertical = 8; //Number of vertical steps
  final double stepHeight = 3.0; // Height of each step

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final stepWidth = (size.width - 10) / numberOfStepsHorizontal;

// Draw steps on the top edge for even steps, and bottom edge for odd steps
    for (int i = 0; i <= numberOfStepsHorizontal; i++) {
      if (i % 2 == 0) {
        final topRect = Rect.fromLTWH(stepWidth * i, 0, stepWidth, stepHeight);
        canvas.drawRect(topRect, paint);
        final bottomRect = Rect.fromLTWH(
            stepWidth * i, size.height - stepHeight, stepWidth, stepHeight);
        canvas.drawRect(bottomRect, paint);
      }
    }

    //Drawing Rectangle on each sides

/* Since the Rectangles have to be made in the sides,
stepHeight is given in the place of width parameter in LTWH and vice versa */

    final sideStepWidth = stepHeight;
    final sideStepHeight = stepWidth;

    for (int i = 1; i <= numberOfStepsVertical; i++) {
      if (i % 2 == 0) {
        final leftRect = Rect.fromLTWH(
            0,
            (sideStepWidth + screenSize.height * .005) * i,
            sideStepWidth,
            sideStepHeight / 2);
        canvas.drawRect(leftRect, paint);
        final rightRect = Rect.fromLTWH(
            (size.width - sideStepWidth),
            (sideStepWidth + screenSize.height * .005) * i,
            sideStepWidth,
            sideStepHeight / 2);
        canvas.drawRect(rightRect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
