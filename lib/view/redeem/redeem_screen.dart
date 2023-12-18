import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/dialog/coupon_generate_dialog.dart';
import 'package:turning_point/helper/custom_app_bar.dart';
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
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
//====================Header Segment with back button and title====================//
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            Container(
              height: screenSize.height * .63,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(255, 229, 26, 1),
                    Color.fromRGBO(255, 235, 80, 0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenSize.height * .025,
                      ),
                      child: Image.asset('assets/images/party_poppers.png'),
                    ),
                    customAppBar(
                        context: context,
                        screenSize: screenSize,
                        title: 'Redeem'),
                    Positioned(
                      right: 3,
                      top: 30,
                      child: Image.asset(
                        'assets/icons/purple_gift_box_icon.png',
                        width: screenSize.width * .235,
                      ),
                    ),

//====================Available Points Container====================//
                    availablePointsContainer(screenSize: screenSize),

                    Positioned(
                      top: screenSize.height * .3,
                      child: redeemOptionsSegment(screenSize: screenSize),
                    ),
                    Positioned(
                      top: screenSize.height * .44,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/gift_voucher.png',
                            width: screenSize.width * .475,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenSize.height * .024),
            redeemTextFieldSegment(
                screenSize: screenSize, controller: controller),
            SizedBox(height: screenSize.height * .022),
            GestureDetector(
              onTap: () async {
                showCouponGenerateDialog(
                    context: context, screenSize: screenSize);
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
                  color: const Color.fromRGBO(0, 189, 190, 1),
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
