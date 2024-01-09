import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/dialog/show_coupon_generate_dialog.dart';
import 'package:turning_point/helper/widget/custom_app_bar.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/redeem/segments/available_points_container.dart';
import 'package:turning_point/view/redeem/segments/redeem_options_segment.dart';
import 'package:turning_point/view/redeem/segments/redeem_textfield_segment.dart';

class RedeemScreen extends StatefulWidget {
  const RedeemScreen({super.key});

  @override
  State<RedeemScreen> createState() => _RedeemScreenState();
}

class _RedeemScreenState extends State<RedeemScreen> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//====================Header Segment with back button and title====================//
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(255, 229, 26, .8),
                    Color.fromRGBO(255, 235, 80, 0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  SafeArea(
                    child: customAppBar(context: context, title: 'Redeem'),
                  ),
                  availablePointsContainer(screenSize: screenSize),
                ],
              ),
            ),
            SizedBox(height: screenSize.height * .04),
            redeemOptionsSegment(screenSize: screenSize),
            SizedBox(height: screenSize.height * .04),
            Image.asset(
              'assets/images/redeem_screen_gift_voucher.png',
              width: screenSize.width * .9,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Note: ',
                  style: GoogleFonts.roboto(
                    color: const Color.fromRGBO(228, 37, 43, 1),
                    fontSize: screenSize.width * .028,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'One point is equal to one rupee',
                  style: GoogleFonts.roboto(
                    fontSize: screenSize.width * .028,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenSize.height * .04),
            redeemTextFieldSegment(
                screenSize: screenSize, controller: controller),
            SizedBox(height: screenSize.height * .032),
            GestureDetector(
              onTap: () async {
                showCouponGenerateDialog(context: context);
                await Future.delayed(
                  const Duration(milliseconds: 2000),
                  () {
                    Navigator.pop(context);
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * .051,
                  vertical: screenSize.width * .021,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromRGBO(0, 99, 255, 1),
                ),
                child: Text(
                  'Redeem',
                  style: GoogleFonts.inter(
                    fontSize: screenSize.width * .031,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenSize.height * .019),
          ],
        ),
      ),
    );
  }
}
