import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/custom_navigator.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/my_app_bar.dart';
import 'package:turning_point/view/referral/total_referral_earned_screen.dart';

part 'segments/coupon_code_container.dart';
part 'segments/referral_instruction_container.dart';
part 'segments/invite_link_container.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({
    super.key, // Added optional Key parameter
  });

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  @override
  void initState() {
    super.initState();
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
                  myAppBar(
                    context: context,
                    title: 'Referral',
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xff0054b4),
                  ),
                  SizedBox(height: screenSize.height * .02),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * .05),
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
                                'Earn 500 Points Each',
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: screenSize.width * .056,
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
                      onTap: () => CustomNavigator.push(
                        context: context,
                        child: const TotalReferralEarnedScreen(),
                      ),
                      child: Container(
                        width: screenSize.width * .86,
                        height: screenSize.height * .08,
                        padding: EdgeInsets.only(
                          left: screenSize.width * .01,
                          right: screenSize.width * .031,
                        ),
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
                                  'Referral Rewards Earned',
                                  style: GoogleFonts.roboto(
                                    color: const Color(0xff727576),
                                    fontSize: screenSize.width * .035,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
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
                                        color: const Color(0xff263238),
                                        fontSize: screenSize.width * .051,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  size: screenSize.width * .06,
                                  color: const Color(0xff455a64),
                                ),
                              ),
                            ),
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
          SizedBox(height: screenSize.height * .04),
          referralCodeContainer(
            context: context,
            couponCode: 'demo123',
          ),
          SizedBox(height: screenSize.height * .03),
          referralInstructionContainer(),
          SizedBox(height: screenSize.height * .04),
          inviteLinkContainer(couponCode: 'demo123'),
        ],
      ),
    );
  }

  // String extractReferralCode(String url) {
  //   RegExp regExp = RegExp(r'/([^/]+)$');
  //   Match? match = regExp.firstMatch(url);

  //   if (match != null && match.groupCount >= 1) {
  //     return match.group(1)!;
  //   } else {
  //     return ''; // Return an empty string if no referral code is found
  //   }
  // }
}
