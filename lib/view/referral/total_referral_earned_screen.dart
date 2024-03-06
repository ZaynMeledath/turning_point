// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalReferralEarnedScreen extends StatefulWidget {
  String walletAmount;

  TotalReferralEarnedScreen({
    super.key,
    required this.walletAmount,
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
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            //---------------Blue Container---------------//
            Container(
              width: double.infinity,
              height: 216,
              color: const Color(0xff0054b4),
              padding: const EdgeInsets.only(
                left: 15,
                top: 15,
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Text('FAQ?',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            )),
                      )
                    ],
                  ),
                  Positioned(
                    top: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Total Referral Earned',
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    )),
                                const SizedBox(height: 8),
                                Text('₹ ${widget.walletAmount}',
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    )),
                                const SizedBox(height: 25),
                                GestureDetector(
                                  onTap: () {
                                    // send the user to subscription screen
                                  },
                                  child: Container(
                                      width: 88,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Center(
                                        child: Text('Redeem Now',
                                            style: GoogleFonts.roboto(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                            )),
                                      )),
                                ),
                                const SizedBox(height: 20)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Positioned(
                      top: 48,
                      right: -8,
                      child: CircleAvatar(
                        radius: 71,
                        backgroundColor: Color.fromRGBO(255, 255, 255, 0.2),
                      )),
                  Positioned(
                    top: 60,
                    right: 7,
                    child: Image.asset(
                      'assets/images/purple_gift_box.png',
                      width: 108,
                      height: 111,
                    ),
                  )
                ],
              ),
            ),

            //referral List

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Referral List',
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                reverse: false,
                addAutomaticKeepAlives: true,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset('assets/images/avatar.png')),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'referrersList[index].name',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
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
      ),
    );
  }
}
