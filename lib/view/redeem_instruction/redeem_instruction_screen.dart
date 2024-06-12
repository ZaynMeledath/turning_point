import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/utils/screen_size.dart';
import 'package:turning_point/view/redeem_instruction/segments/redeem_instruction_option_container.dart';

class RedeemInstructionScreen extends StatelessWidget {
  const RedeemInstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //====================Header Segment with back button, title and doodle image====================//
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: Hero(
          tag: 'back_button',
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: screenSize.width * .051,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: Text(
          'Redeem',
          style: GoogleFonts.inter(
            fontSize: screenSize.width * .041,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * .115,
                vertical: screenSize.height * .01,
              ),
              child: Image.asset('assets/images/redeem_screen_doodle.png'),
            ),
            SizedBox(height: screenSize.height * .02),
//====================Body Segment====================//
            redeemInstructionOptionContainer(
              screenSize: screenSize,
              title: 'Buy Coupon',
              containerColor: const Color.fromRGBO(255, 233, 240, 1),
              iconPath: '',
            ),
            SizedBox(
              height: screenSize.height * .03,
            ),
            redeemInstructionOptionContainer(
              screenSize: screenSize,
              title: 'Buy Coupon',
              containerColor: const Color.fromRGBO(255, 248, 237, 1),
              iconPath: '',
            ),
            SizedBox(height: screenSize.height * .03),
            redeemInstructionOptionContainer(
              screenSize: screenSize,
              title: 'Buy Coupon',
              containerColor: const Color.fromRGBO(242, 224, 255, 1),
              iconPath: '',
            ),
            SizedBox(height: screenSize.height * .03),
            redeemInstructionOptionContainer(
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
