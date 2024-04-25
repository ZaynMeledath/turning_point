import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point/bloc/lucky_draw/lucky_draw_bloc.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
import 'package:turning_point/helper/custom_navigator.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/my_app_bar.dart';
import 'package:turning_point/helper/widget/custom_loading.dart';
import 'package:turning_point/view/contest/contest_screen.dart';
import 'package:turning_point/view/lucky_draw/winners_display_screen.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

part 'segments/gift_boxes_segment.dart';
part 'all_gifts_screen.dart';
part 'segments/count_down_container.dart';
part 'segments/count_down_timer_segment.dart';
part 'segments/days_left_container.dart';
part 'segments/gift_box_container.dart';

class LuckyDrawScreen extends StatefulWidget {
  const LuckyDrawScreen({super.key});

  @override
  State<LuckyDrawScreen> createState() => _LuckyDrawScreenState();
}

class _LuckyDrawScreenState extends State<LuckyDrawScreen> {
  final audioPlayer = AudioPlayer();
  bool isAudioPlaying = false;

  @override
  void didChangeDependencies() {
    disableWakeLock();
    if (preloadBloc.state.controllers.isNotEmpty) {
      preloadBloc.pauseCurrentController();
    }
    preloadBloc.add(ReelsScreenToggleEvent(isReelsVisible: false));
    super.didChangeDependencies();
  }

  void disableWakeLock() {
    setState(() {
      WakelockPlus.disable();
    });
  }

  @override
  void dispose() {
    super.dispose();
    luckyDrawBloc.add(LuckyDrawTimerDisposeEvent());
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (preloadBloc.state.controllers.isNotEmpty) {
      preloadBloc.pauseCurrentController();
    }
    preloadBloc.add(ReelsScreenToggleEvent(isReelsVisible: false));
    luckyDrawBloc.add(LuckyDrawLoadEvent());
    return Scaffold(
      backgroundColor: const Color.fromRGBO(19, 24, 54, 1),
      body: BlocBuilder<LuckyDrawBloc, LuckyDrawState>(
        builder: (context, state) {
          switch (state) {
//====================Lucknny Draw Loading State====================//
            case LuckyDrawLoadingState():
              return spinningLinesLoading(color: Colors.white);

//====================Lucky Draw Winner Display State====================//
            case LuckyDrawWinnersDisplayState():
              return const WinnersDisplayScreen();

//====================Lucky Draw Loaded State====================//
            case LuckyDrawLoadedState():
              if (state.contestModel != null) {
                return Column(
                  children: [
                    SizedBox(height: screenSize.height * .09),
                    //--------------------Lucky Draw Image--------------------//
                    Image.asset(
                      'assets/images/lucky_draw_image.png',
                      width: screenSize.width * .62,
                    ),

                    SizedBox(height: screenSize.height * .024),
                    //--------------------Days Left Blue Container--------------------//
                    joinLuckyDraw(context: context),

                    SizedBox(height: screenSize.height * .034),
                    //--------------------Count Down Timer--------------------//
                    countDownTimerSegment(
                      days: state.timeMap!['timeInDays']!,
                      hours: state.timeMap!['timeInHours']!,
                      minutes: state.timeMap!['timeInMinutes']!,
                      seconds: state.timeMap!['timeInSeconds']!,
                    ),

                    SizedBox(height: screenSize.height * .037),
                    //--------------------Gifts Segment--------------------//
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * .06,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Gifts',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: screenSize.width * .036,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => CustomNavigator.push(
                              context: context,
                              child: const AllGiftsScreen(),
                            ),
                            child: Text(
                              'View All',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: screenSize.width * .031,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenSize.height * .015),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * .05,
                      ),
                      child: giftBoxesSegment(context),
                    ),
                  ],
                );
              } else {
                return SafeArea(
                  child: LiquidPullToRefresh(
                    height: 80,
                    animSpeedFactor: 1.5,
                    showChildOpacityTransition: false,
                    color: const Color.fromRGBO(31, 51, 170, .2),
                    backgroundColor: Colors.white,
                    onRefresh: () async {
                      luckyDrawBloc.add(LuckyDrawLoadEvent());
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: screenSize.height * .26),
                            Lottie.asset(
                              'assets/lottie/no_data_animation.json',
                              width: screenSize.width * .5,
                            ),
                            Text(
                              'No Lucky Draw Available at the moment',
                              style: GoogleFonts.inter(
                                fontSize: screenSize.width * .04,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: .1,
                              ),
                            ),
                            SizedBox(height: screenSize.height * .1)
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}








//====================Background Decoration Circles====================//
                      // Positioned(
                      //   bottom: -screenSize.width * .82,
                      //   width: screenSize.width * 1.3,
                      //   height: screenSize.width * 1.3,
                      //   child: Container(
                      //     decoration: const BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Color.fromRGBO(226, 181, 54, 1),
                      //         ),
                      //         BoxShadow(
                      //           color: Color.fromRGBO(209, 99, 1, 1),
                      //           offset: Offset(0, 4),
                      //           blurRadius: 121,
                      //           spreadRadius: 4,
                      //           blurStyle: BlurStyle.outer,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Positioned(
                      //   bottom: -screenSize.width * .7,
                      //   width: screenSize.width * .8,
                      //   height: screenSize.width * .8,
                      //   child: Container(
                      //     decoration: const BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Color.fromRGBO(226, 181, 54, 1),
                      //         ),
                      //         BoxShadow(
                      //           color: Color.fromRGBO(209, 99, 1, .6),
                      //           offset: Offset(0, 4),
                      //           blurRadius: 121,
                      //           spreadRadius: 47,
                      //           blurStyle: BlurStyle.normal,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),