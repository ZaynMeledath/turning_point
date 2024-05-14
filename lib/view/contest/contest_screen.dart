import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';
import 'package:turning_point/bloc/contest/contest_bloc.dart';
import 'package:turning_point/bloc/contest/join_contest_bloc.dart';
import 'package:turning_point/dialog/show_animated_generic_dialog.dart';
import 'package:turning_point/helper/custom_navigator.dart';
import 'package:turning_point/helper/widget/my_app_bar.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_loading.dart';
import 'package:turning_point/resources/contest_repository.dart';
import 'package:turning_point/service/Exception/user_exceptions.dart';
import 'package:turning_point/view/contest/segments/banner_segment.dart';
import 'package:turning_point/view/kyc/kyc_screen.dart';

part 'segments/contest_card_inner_container.dart';
part 'segments/contest_card.dart';
part 'segments/contest_count_down_container.dart';
part 'contest_details_screen.dart';
part 'segments/contest_heading.dart';

class ContestScreen extends StatefulWidget {
  const ContestScreen({super.key});

  @override
  State<ContestScreen> createState() => _ContestScreenState();
}

class _ContestScreenState extends State<ContestScreen> {
  @override
  void dispose() async {
    super.dispose();
    contestBloc.add(ContestTimerDisposeEvent());
  }

  Future<void> _handleRefresh() async {
    await ContestRepository.getContests();
    contestBloc.add(ContestLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    contestBloc.add(ContestLoadEvent());
    return BlocListener<JoinContestBloc, JoinContestState>(
      listener: (context, state) {
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
      child: Scaffold(
        appBar: myAppBar(context: context, title: 'Contest'),
        body: SafeArea(
          child: Column(
            children: [
              bannerSegment(),
              SizedBox(height: screenSize.height * .005),
              Container(
                height: 6,
                color: const Color.fromRGBO(247, 247, 247, 1),
              ),
              SizedBox(height: screenSize.height * .007),
              contestHeading(),
              SizedBox(height: screenSize.height * .007),
              Container(
                height: 1,
                margin:
                    EdgeInsets.symmetric(horizontal: screenSize.width * .051),
                color: const Color.fromRGBO(237, 237, 237, 1),
              ),
              BlocBuilder<ContestBloc, ContestState>(
                builder: (context, state) {
                  switch (state) {
                    case ContestLoadingState():
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(height: screenSize.height * .1),
                            spinningLinesLoading(),
                          ],
                        ),
                      );
                    case ContestLoadedState():
                      if (state.contestModelList != null &&
                          state.contestModelList!.isNotEmpty) {
                        return Expanded(
                          child: StackedCardCarousel(
                            initialOffset: screenSize.height * .018,
                            spaceBetweenItems: screenSize.height * .32,
                            items: [
                              for (int i = 0;
                                  i < state.contestModelList!.length;
                                  i++)
                                contestCard(context: context, index: i),
                            ],
                          ),
                        );
                      } else {
                        return LiquidPullToRefresh(
                          height: 60,
                          animSpeedFactor: 2,
                          showChildOpacityTransition: false,
                          color: const Color.fromRGBO(89, 165, 255, 1),
                          backgroundColor: Colors.white,
                          onRefresh: () => _handleRefresh(),
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(height: screenSize.height * .03),
                                  Lottie.asset(
                                    'assets/lottie/no_data_animation.json',
                                    width: screenSize.width * .5,
                                  ),
                                  Text(
                                    'No Contest Available at the moment',
                                    style: GoogleFonts.inter(
                                      fontSize: screenSize.width * .038,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(.75),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }

                    default:
                      return spinningLinesLoading();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
