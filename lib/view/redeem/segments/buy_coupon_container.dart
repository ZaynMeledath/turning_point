import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turning_point/bloc/contest/contest_bloc.dart';
import 'package:turning_point/bloc/contest/join_contest_bloc.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/model/contest_model.dart';
import 'package:turning_point/view/contest/contest_screen.dart';
import 'package:turning_point/view/redeem/redeem_screen.dart';

Widget buyCouponContainer({
  required BuildContext context,
  required int contestIndex,
  required ContestModel contestModel,
  required String daysLeft,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(12),
    onTap: () {
      Navigator.of(context).push(
        PageTransition(
          child: ContestDetailsScreen(
            index: contestIndex,
          ),
          type: PageTransitionType.scale,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 400),
        ),
      );
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 15, top: 5),
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * .026),
      height: screenSize.height * .096,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 4,
            spreadRadius: -2,
            color: Colors.black.withOpacity(.2),
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              '${contestModel.image}',
              width: screenSize.width * .12,
            ),
          ),
          SizedBox(width: screenSize.width * .025),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: screenSize.width * .3,
                child: Text(
                  contestModel.name.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: screenSize.width * .035,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: screenSize.width * .3,
                child: Text(
                  int.parse(daysLeft) < 2
                      ? 'Ends in a day'
                      : 'Ends in $daysLeft days',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: screenSize.width * .025,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(86, 86, 86, 1),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: screenSize.width * .01),
          buyCouponCounter(contestIndex: contestIndex),
          //====================Yellow Buy Coupon Container====================//
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: screenSize.height * .01),
                    InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        joinContestBloc.add(
                          JoinContestEvent(
                            contestModel: contestModel,
                            contestIndex: contestIndex,
                            entryCount:
                                contestBloc.state.entryCount[contestIndex],
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * .028,
                          vertical: screenSize.height * .009,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color.fromRGBO(0, 146, 110, 1),
                        ),
                        child: Center(
                          child: Text(
                            'Buy Coupon',
                            style: GoogleFonts.inter(
                              fontSize: screenSize.width * .031,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenSize.height * .005),
                    Text(
                      'You have ${contestModel.userJoinedCount ?? 0}',
                      style: GoogleFonts.inter(
                        fontSize: screenSize.width * .026,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(86, 86, 86, 1),
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
  );
}
