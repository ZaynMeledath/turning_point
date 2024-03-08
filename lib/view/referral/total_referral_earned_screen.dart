// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_app_bar.dart';

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
            height: 300,
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
                      Text(
                        'Total Referral Earned',
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: screenSize.width * .036,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '₹ 2450',
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: screenSize.width * .06,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // send the user to subscription screen
                        },
                        child: Container(
                          width: 88,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: Text(
                              'Redeem Now',
                              style: GoogleFonts.roboto(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  Positioned(
                    right: -5,
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
                          'assets/images/avatar.png',
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
