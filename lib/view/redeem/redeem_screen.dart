import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/view/redeem/segments/redeem_option_container.dart';

class RedeemScreen extends StatelessWidget {
  const RedeemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: screenSize.height * .009),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * .03),
              child: Row(
                children: [
//====================Header Segment with back button, title and doodle image====================//
                  Hero(
                    tag: 'back_button',
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: screenSize.height * .033,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(width: screenSize.width * .041),
                  Text(
                    'Redeem',
                    style: GoogleFonts.inter(
                      fontSize: screenSize.width * .041,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * .115,
                vertical: screenSize.height * .01,
              ),
              child: Image.asset('assets/images/redeem_screen_doodle.png'),
            ),
            SizedBox(height: screenSize.height * .02),
//====================Body Segment====================//
            redeemOptionContainer(
              screenSize: screenSize,
              title: 'Buy Coupon',
              containerColor: const Color.fromRGBO(255, 233, 240, 1),
              iconPath: '',
            ),
            SizedBox(
              height: screenSize.height * .03,
            ),
            redeemOptionContainer(
              screenSize: screenSize,
              title: 'Buy Coupon',
              containerColor: const Color.fromRGBO(255, 248, 237, 1),
              iconPath: '',
            ),
            SizedBox(height: screenSize.height * .03),
            redeemOptionContainer(
              screenSize: screenSize,
              title: 'Buy Coupon',
              containerColor: const Color.fromRGBO(242, 224, 255, 1),
              iconPath: '',
            ),
            SizedBox(height: screenSize.height * .03),
            redeemOptionContainer(
              screenSize: screenSize,
              title: 'Buy Coupon',
              containerColor: const Color.fromRGBO(255, 255, 255, 1),
              iconPath: '',
            ),
            SizedBox(height: screenSize.height * .01),
          ],
        ),
      ),
    );
  }
}
