import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';

class SubscribedScreen extends StatefulWidget {
  const SubscribedScreen({super.key});

  @override
  State<SubscribedScreen> createState() => _SubscribedScreenState();
}

class _SubscribedScreenState extends State<SubscribedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: screenSize.width * .06),

//---------------Total Referrals---------------//
          Container(
            width: width * .86,
            height: 48,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x16000000),
                    offset: Offset(0, 1),
                    blurRadius: 4,
                  )
                ]),
            child: Row(
              children: [
                SizedBox(width: width * .02),
                Image.asset(
                  'assets/images/link 1.png',
                  width: 27,
                  height: 27,
                ),
                SizedBox(width: width * .03),
                Text('Total Referrals',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff263238),
                    )),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 35),
                      child: Text(
                        '48',
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff0054b4),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
