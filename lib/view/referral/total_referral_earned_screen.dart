// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/custom_navigator.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/my_app_bar.dart';
import 'package:turning_point/view/redeem/redeem_screen.dart';
import 'package:turning_point/view/referral/segments/my_referrals_segment.dart';
import 'package:turning_point/view/referral/segments/referral_rewards_segment.dart';

class TotalReferralEarnedScreen extends StatefulWidget {
  const TotalReferralEarnedScreen({
    super.key,
  });

  @override
  State<TotalReferralEarnedScreen> createState() =>
      _TotalReferralEarnedScreenState();
}

class _TotalReferralEarnedScreenState extends State<TotalReferralEarnedScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
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
                      myAppBar(
                        context: context,
                        title: '',
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xff0054b4),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: screenSize.width * .05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: screenSize.height * .011),
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

          //---------------Rewards and My Referrals Container---------------//
          SizedBox(height: screenSize.height * .02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * .06),
            child: Container(
              width: double.infinity,
              height: screenSize.height * .046,
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * .006,
                vertical: screenSize.height * .003,
              ),
              decoration: BoxDecoration(
                color: const Color(0xfff5f6ff),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TabBar(
                dividerColor: Colors.transparent,
                controller: _controller,
                labelColor: const Color(0xff0054b4),
                unselectedLabelColor: const Color(0xff222222),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x16000000),
                      offset: Offset(0, 1),
                      blurRadius: 1,
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                ),
                tabs: [
                  Text(
                    'Rewards',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .034,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'My Referrals',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .034,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _controller,
              children: [
                referralRewardsSegment(context),
                myReferralsSegment(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
