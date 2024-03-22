import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/model/contest_model.dart';
import 'package:turning_point/view/redeem/redeem_screen.dart';

Widget contestListSegment({
  required ContestModel contestModel,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15, top: 5),
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .026),
    height: screenSize.height * .07,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white.withOpacity(.8),
          Colors.white.withOpacity(.9),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          offset: const Offset(1, 1),
          blurRadius: 2,
          color: Colors.black.withOpacity(.07),
        ),
        BoxShadow(
          offset: const Offset(-1, -1),
          blurRadius: 2,
          color: Colors.black.withOpacity(.07),
        ),
      ],
    ),
    child: Row(
      children: [
        SizedBox(
          width: screenSize.width * .34,
          child: Text(
            'Contest Name Something',
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: screenSize.width * .035,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        buyCouponCounter(),
//====================Yellow Buy Coupon Container====================//
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // height: screenSize.height * .03,
                    // padding: const EdgeInsets.only(
                    //   left: 2,
                    //   right: 6,
                    //   top: 2,
                    //   bottom: 2,
                    // ),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * .03,
                      vertical: screenSize.height * .007,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color.fromRGBO(255, 215, 0, 1),
                          Color.fromRGBO(255, 238, 141, 1),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Buy Coupon',
                        style: GoogleFonts.inter(
                          fontSize: screenSize.width * .031,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
