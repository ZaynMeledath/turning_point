import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_app_bar.dart';
import 'package:turning_point/view/referral/total_referral_earned_screen.dart';

part 'segments/coupon_code_container.dart';
part 'segments/referral_instruction_container.dart';
part 'segments/invite_link_container.dart';

class ReferScreen extends StatefulWidget {
  const ReferScreen({
    super.key, // Added optional Key parameter
  });

  @override
  State<ReferScreen> createState() => _ReferScreenState();
}

class _ReferScreenState extends State<ReferScreen> {
  StreamSubscription<Map>? streamSubscriptionDeepLink;
  String? newReferralCode;
  String? deeplink;
  String? generatedReferalCode;

  @override
  void initState() {
    super.initState();

    //first check if the referal code is already saved
    // generate the referal code and update it to the current user and save it in local database

    // initializeDeepLinkData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          //----------Blue Container----------//
          Container(
            width: double.infinity,
            height: screenSize.height * .42,
            color: const Color(0xff0054b4),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customAppBar(
                    context: context,
                    title: 'Referral',
                    foregroundColor: Colors.white,
                  ),
                  SizedBox(height: screenSize.height * .02),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * .06),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Refer Your Friend',
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: screenSize.width * .035,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Earn ₹25 Each',
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: screenSize.width * .06,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/images/purple_gift_box.png',
                          width: screenSize.width * .22,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenSize.height * .01),

                  //Total referrals earned container

                  Center(
                    child: GestureDetector(
                      child: Container(
                        width: screenSize.width * .86,
                        height: screenSize.height * .08,
                        padding:
                            EdgeInsets.only(right: screenSize.width * .031),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.asset(
                              'assets/images/purple_gift_box.png',
                              width: screenSize.width * .14,
                            ),
                            SizedBox(width: screenSize.width * .015),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Total Referrals Earned',
                                  style: GoogleFonts.roboto(
                                    color: const Color(0xff727576),
                                    fontSize: screenSize.width * .035,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text('₹ 2450',
                                    style: GoogleFonts.roboto(
                                      color: const Color(0xff263238),
                                      fontSize: screenSize.width * .051,
                                      fontWeight: FontWeight.w500,
                                    ))
                              ],
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TotalReferralEarnedScreen(
                                                walletAmount: '10'),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.keyboard_arrow_right,
                                    size: screenSize.width * .06,
                                  ),
                                  color: const Color(0xff455a64),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                          'Send a referral link to your friends via\nWhatsapp / Facebook',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: screenSize.width * .035,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  ),
                  SizedBox(height: screenSize.height * .007)
                ],
              ),
            ),
          ),

          //---------------White Container---------------//
          SizedBox(height: screenSize.height * .07),
          const CouponCodeContainer(
            couponCode: 'demo123',
          ),
          SizedBox(height: screenSize.height * .02),
          const ReferralInstructionContainer(),
          const SizedBox(height: 10),
          const InviteLinkContainer(couponCode: 'demo123'),
        ],
      ),
    );
  }

  String extractReferralCode(String url) {
    RegExp regExp = RegExp(r'/([^/]+)$');
    Match? match = regExp.firstMatch(url);

    if (match != null && match.groupCount >= 1) {
      return match.group(1)!;
    } else {
      return ''; // Return an empty string if no referral code is found
    }
  }
}