// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/custom_navigator.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_app_bar.dart';
import 'package:turning_point/view/redeem/redeem_screen.dart';

class TotalReferralEarnedScreen extends StatefulWidget {
  const TotalReferralEarnedScreen({
    super.key,
  });

  @override
  State<TotalReferralEarnedScreen> createState() =>
      _TotalReferralEarnedScreenState();
}

class _TotalReferralEarnedScreenState extends State<TotalReferralEarnedScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //---------------Blue Container---------------//
          Container(
            width: double.infinity,
            height: screenSize.height * .27,
            color: const Color(0xff0054b4),
            child: SafeArea(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customAppBar(
                        context: context,
                        title: '',
                        foregroundColor: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: screenSize.width * .05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: screenSize.height * .015),
                            Text(
                              'Total Referrals Earned',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: screenSize.width * .038,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: screenSize.height * .007),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/coin_icon.png',
                                  width: screenSize.width * .065,
                                ),
                                SizedBox(width: screenSize.width * .005),
                                Text(
                                  '2450',
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: screenSize.width * .06,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenSize.height * .02),
                            GestureDetector(
                              onTap: () {
                                CustomNavigator.push(
                                  context: context,
                                  child: const RedeemScreen(),
                                );
                              },
                              child: Container(
                                width: screenSize.width * .2,
                                height: screenSize.width * .07,
                                decoration: BoxDecoration(
                                  // color: Colors.white,
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color.fromRGBO(255, 221, 84, 1),
                                      Colors.white.withOpacity(1),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: Text(
                                    'Redeem',
                                    style: GoogleFonts.roboto(
                                      fontSize: screenSize.width * .03,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: -6,
                    bottom: screenSize.height * .012,
                    child: CircleAvatar(
                      radius: screenSize.width * .17,
                      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.2),
                      child: Image.asset('assets/images/purple_gift_box.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //referral List

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Referral List',
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
          ),

          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 0),
              itemCount: 5,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/avatar.jpg',
                          width: screenSize.width * .2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'Name',
                        style: GoogleFonts.roboto(
                          fontSize: screenSize.width * .035,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
