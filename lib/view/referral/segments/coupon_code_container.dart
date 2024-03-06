part of '../refer_screen.dart';

class CouponCodeContainer extends StatelessWidget {
  final String couponCode;
  const CouponCodeContainer({
    required this.couponCode,
    super.key,
  });

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
      child: SizedBox(
        width: screenSize.width * .75,
        height: screenSize.height * .09,
        child: Stack(
          children: [
            Container(
              width: screenSize.width * .75,
              height: screenSize.height * .09,
              color: Colors.black,
              child: CustomPaint(
                painter: StepsPainter(),
              ),
            ),
            Positioned(
              left: screenSize.width * .75 * .17,
              top: screenSize.height * .08 * .2,
              child: Text('Your Referral Code',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: screenSize.width * .031,
                    fontWeight: FontWeight.w400,
                  )),
            ),
            Positioned(
              left: screenSize.width * .75 * .17,
              bottom: screenSize.height * .08 * .25,
              child: Text(couponCode,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: screenSize.width * .051,
                    fontWeight: FontWeight.w700,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(left: screenSize.width * .75 * .61),
              child: const VerticalDivider(
                color: Colors.white,
                indent: 10,
                endIndent: 10,
              ),
            ),
            Positioned(
              right: screenSize.width * .75 * .07,
              top: screenSize.height * .08 * .40,
              child: GestureDetector(
                onTap: () {
                  _copyToClipboard(couponCode);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Coupon code copied to clipboard!')),
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
            ),
          ],
        ),
      ),
    ));
  }
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
            0, (sideStepWidth + 3.5) * i, sideStepWidth, sideStepHeight / 2);
        canvas.drawRect(leftRect, paint);
        final rightRect = Rect.fromLTWH((size.width - sideStepWidth),
            (sideStepWidth + 3.5) * i, sideStepWidth, sideStepHeight / 2);
        canvas.drawRect(rightRect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
