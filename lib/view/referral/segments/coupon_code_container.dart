part of '../referral_screen.dart';

void copyToClipboard(String text) {
  Clipboard.setData(ClipboardData(text: text));
}

Widget referralCodeContainer({
  required BuildContext context,
}) {
  final couponCode = profileBloc.state.userModel!.refCode.toString();
  return Container(
    width: screenSize.width * .8,
    height: screenSize.width * .175,
    decoration: BoxDecoration(
      color: Colors.black87,
      borderRadius: BorderRadius.circular(6),
    ),
    child: CustomPaint(
      // clipper: CustomClipperWidget(),
      painter: StepsPainter(),
      child: Row(
        children: [
          SizedBox(width: screenSize.width * .06),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Referral Code',
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
              copyToClipboard(couponCode);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Referral code copied to clipboard!'),
                ),
              );
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

// class CustomClipperWidget extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();

//     const numberOfSteps = 14;
//     const numberOfVerticalSteps = 3;
//     final stepSize = size.width / numberOfSteps;

//     path.moveTo(0, size.height * .05);

//     for (int i = 1; i <= numberOfSteps; i++) {
//       path.lineTo(stepSize * i, stepSize);
//       path.lineTo(stepSize * i, 0);
//       i++;
//       path.lineTo(stepSize * i, 0);
//       path.lineTo(stepSize * i, stepSize);
//     }

//     for (int i = 1; i <= numberOfVerticalSteps; i++) {
//       path.lineTo(size.width - stepSize, stepSize * i);
//       path.lineTo(size.width, stepSize * i);
//       i++;
//       path.lineTo(size.width, stepSize * i);
//       path.lineTo(size.width - size.width, stepSize * i);
//     }

//     for (int i = 14; i > 0; i--) {
//       path.lineTo(stepSize * i, stepSize);
//       path.lineTo(stepSize * i, 0);
//       i--;
//       path.lineTo(stepSize * i, 0);
//       path.lineTo(stepSize * i, stepSize);
//     }

//     for (int i = 3; i > 0; i--) {
//       path.lineTo(size.width - stepSize, stepSize * i);
//       path.lineTo(size.width, stepSize * i);
//       i--;
//       path.lineTo(size.width, stepSize * i);
//       path.lineTo(size.width - size.width, stepSize * i);
//     }

//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }

class StepsPainter extends CustomPainter {
  final int numberOfStepsHorizontal =
      28; // Number of horizontal rectangular steps
  final int numberOfStepsVertical = 8; //Number of vertical steps
  final double stepHeight = screenSize.width * .012; // Height of each step

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final stepWidth =
        (size.width - (screenSize.width * .028)) / numberOfStepsHorizontal;

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
            (sideStepWidth + screenSize.height * .004) * i,
            sideStepWidth,
            sideStepHeight / 2);
        canvas.drawRect(leftRect, paint);
        final rightRect = Rect.fromLTWH(
            (size.width - sideStepWidth),
            (sideStepWidth + screenSize.height * .004) * i,
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
