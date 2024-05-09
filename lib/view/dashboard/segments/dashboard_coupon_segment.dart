import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turning_point/bloc/contest/contest_bloc.dart';
import 'package:turning_point/bloc/contest/join_contest_bloc.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/contest/contest_screen.dart';

Widget dashboardCouponSegment({required BuildContext context}) {
  return BlocBuilder<ContestBloc, ContestState>(
    builder: (context, state) {
      if (state.contestModelList != null &&
          state.contestModelList!.isNotEmpty) {
        return Expanded(
          child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.contestModelList!.length,
              itemBuilder: (context, index) {
                final contestModel = state.contestModelList![index];
                final daysLeft = state.timeList![index]['timeInDays']!;
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * .051,
                    vertical: screenSize.height * .013,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.of(context).push(
                        PageTransition(
                          child: ContestDetailsScreen(
                            index: index,
                          ),
                          type: PageTransitionType.scale,
                          alignment: Alignment.center,
                          duration: const Duration(milliseconds: 500),
                          reverseDuration: const Duration(milliseconds: 400),
                        ),
                      );
                    },
                    child: Container(
                      // margin: EdgeInsets.only(
                      //   bottom: 15,
                      //   top: 5,
                      //   left: screenSize.width * .051,
                      //   right: screenSize.width * .051,
                      // ),
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * .026),
                      height: screenSize.height * .08,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            blurRadius: 4,
                            spreadRadius: 1,
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
                                width: screenSize.width * .5,
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
                                width: screenSize.width * .5,
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
                          SizedBox(width: screenSize.width * .025),

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
                                            contestIndex: index,
                                            entryCount: contestBloc
                                                .state.entryCount[index],
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: screenSize.width * .028,
                                          vertical: screenSize.height * .009,
                                        ),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color.fromRGBO(0, 146, 110, 1),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'x${contestModel.userJoinedCount.toString()}',
                                            style: GoogleFonts.inter(
                                              fontSize: screenSize.width * .031,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
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
                    ),
                  ),
                );
              }),
        );
      } else {
        return SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Lottie.asset(
                  'assets/lottie/no_data_animation.json',
                  width: screenSize.width * .3,
                ),
                Text(
                  "No coupons available at the moment",
                  style: GoogleFonts.inter(
                    fontSize: screenSize.width * .034,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(.75),
                  ),
                ),
                SizedBox(height: screenSize.height * .02),
              ],
            ),
          ),
        );
      }
    },
  );
}
