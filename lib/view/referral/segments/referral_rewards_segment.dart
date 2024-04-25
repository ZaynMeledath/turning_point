import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/referral/segments/scratch_card_pop_up.dart';

Widget referralRewardsSegment(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(bottom: screenSize.height * .025),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * .051),
      child: Column(
        children: [
//---------------Scrath Cards---------------//
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.only(top: screenSize.height * .025),
              itemCount: 2,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(bottom: screenSize.height * .025),
                child: GestureDetector(
                  onTap: () => scratchCardPopUp(context),
                  child: Image.asset(
                    'assets/images/star_pattern.png',
                  ),
                ),
              ),
            ),
          ),

//---------------See Rewards History--------------//
          Container(
            width: screenSize.width * .84,
            height: screenSize.height * .055,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x16000000),
                  offset: Offset(1, 1),
                  blurRadius: 4,
                ),
                BoxShadow(
                  color: Color(0x16000000),
                  offset: Offset(-1, -1),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              children: [
                SizedBox(width: screenSize.width * .019),
                Image.asset(
                  'assets/images/purple_gift_box.png',
                  width: screenSize.width * .085,
                ),
                SizedBox(width: screenSize.width * .019),
                Text(
                  'See Reward History',
                  style: GoogleFonts.roboto(
                    fontSize: screenSize.width * .036,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff0054b4),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: screenSize.width * .036),
                      child: const Icon(
                        Icons.keyboard_arrow_right,
                        color: Color(0xff263238),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
