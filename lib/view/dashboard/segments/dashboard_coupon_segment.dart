import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turning_point/bloc/contest/contest_bloc.dart';
import 'package:turning_point/bloc/contest/join_contest_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/constants/constants.dart';
import 'package:turning_point/dialog/show_animated_generic_dialog.dart';
import 'package:turning_point/dialog/show_loading_dialog.dart';
import 'package:turning_point/utils/custom_navigator.dart';
import 'package:turning_point/utils/screen_size.dart';
import 'package:turning_point/service/Exception/user_exceptions.dart';
import 'package:turning_point/view/contest/contest_screen.dart';
import 'package:turning_point/view/kyc/kyc_screen.dart';

Widget dashboardCouponSegment({required BuildContext context}) {
  dynamic closeDialog;
  return BlocListener<JoinContestBloc, JoinContestState>(
    listener: (context, state) {
      if (state is! JoinContestLoadingState && closeDialog != null) {
        closeDialog = null;
        Navigator.pop(context);
      }
      if (state is JoinContestLoadingState) {
        closeDialog = showLoadingDialog(context: context);
      }
      if (state is JoinContestErrorState) {
        switch (state.exception) {
          case InsufficientBalanceToJoinContestException():
            showAnimatedGenericDialog(
              context: context,
              iconPath: 'assets/lottie/insufficient_balance_animation.json',
              title: 'Oops',
              content: 'Insufficient Balance to join the\ncontest',
              buttons: {'Dismiss': null},
              iconWidth: screenSize.width * .25,
            );
            break;
          case VerificationRequiredToJoinContestException():
            if (profileBloc.state.userModel!.kycStatus == KycStatus.SUBMITTED) {
              showAnimatedGenericDialog(
                context: context,
                iconPath: 'assets/lottie/kyc_verification_animation.json',
                title: 'Not Verified',
                content:
                    'Your KYC verification is pending. Please await verification.',
                buttons: {'OK': null},
                iconWidth: screenSize.width * .2,
              );
            } else {
              showAnimatedGenericDialog(
                context: context,
                iconPath: 'assets/lottie/kyc_verification_animation.json',
                title: 'Not Verified',
                content: 'KYC should be verified to join the\ncontest',
                buttons: {
                  'Dismiss': null,
                  'Verify KYC': () {
                    Navigator.pop(context);
                    CustomNavigator.push(
                      context: context,
                      child: const KycScreen(),
                    );
                  },
                },
                iconWidth: screenSize.width * .2,
              );
            }
            break;
          default:
            showAnimatedGenericDialog(
              context: context,
              iconPath: 'assets/lottie/something_went_wrong_animation.json',
              title: 'Error',
              content: 'Something Went Wrong',
              buttons: {'Dismiss': null},
              iconWidth: screenSize.width * .2,
            );
        }
      } else if (state is ContestJoinedState) {
        showAnimatedGenericDialog(
          context: context,
          iconPath: 'assets/images/points_received_dialog_image.png',
          title: 'Joined Contest!',
          content: 'You have Successfully joined\n${state.contestModel.name}',
          buttons: {'Done': null},
        );
      }
    },
    child: BlocBuilder<ContestBloc, ContestState>(
      builder: (context, contestState) {
        if (contestState.contestModelList != null &&
            contestState.contestModelList!.isNotEmpty) {
          return SizedBox(
            height:
                screenSize.height * .11 * contestState.contestModelList!.length,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: contestState.contestModelList!.length,
                itemBuilder: (context, index) {
                  final contestModel = contestState.contestModelList![index];
                  final daysLeft = contestState.timeList![index]['timeInDays']!;
                  return Padding(
                    padding: EdgeInsets.only(
                      left: screenSize.width * .051,
                      right: screenSize.width * .051,
                      top: screenSize.height * .013,
                      bottom: screenSize.height * .007,
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
                                      color:
                                          const Color.fromRGBO(86, 86, 86, 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: screenSize.width * .025),

                            //====================Coupon Entry Count Container====================//
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
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
    ),
  );
}
