import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point/bloc/lucky_draw/lucky_draw_bloc.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
import 'package:turning_point/helper/custom_navigator.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_app_bar.dart';
import 'package:turning_point/helper/widget/custom_loading.dart';
import 'package:turning_point/view/contest/contest_screen.dart';

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
  @override
  void initState() {
    preloadBloc.state.isReelsVisible = false;

    if (preloadBloc.state.controllers.isNotEmpty) {
      preloadBloc.pauseCurrentController();
    }
    super.initState();
  }

  @override
  void dispose() {
    luckyDrawBloc.add(LuckyDrawTimerDisposeEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    luckyDrawBloc.add(LuckyDrawLoadEvent());
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 204, 0, 1),
      body: SafeArea(
        child: BlocBuilder<LuckyDrawBloc, LuckyDrawState>(
          builder: (context, state) {
            switch (state) {
              case LuckyDrawLoadingState():
                return spinningLinesLoading(color: Colors.red);
              case LuckyDrawLoadedState():
                if (state.contestModel != null) {
                  return Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      //====================Background Decoration Circles====================//
                      Positioned(
                        bottom: -screenSize.width * .82,
                        width: screenSize.width * 1.3,
                        height: screenSize.width * 1.3,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(226, 181, 54, 1),
                              ),
                              BoxShadow(
                                color: Color.fromRGBO(209, 99, 1, 1),
                                offset: Offset(0, 4),
                                blurRadius: 121,
                                spreadRadius: 4,
                                blurStyle: BlurStyle.outer,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -screenSize.width * .7,
                        width: screenSize.width * .8,
                        height: screenSize.width * .8,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(226, 181, 54, 1),
                              ),
                              BoxShadow(
                                color: Color.fromRGBO(209, 99, 1, .6),
                                offset: Offset(0, 4),
                                blurRadius: 121,
                                spreadRadius: 47,
                                blurStyle: BlurStyle.normal,
                              ),
                            ],
                          ),
                        ),
                      ),

                      Column(
                        children: [
                          SizedBox(height: screenSize.height * .038),
                          //====================Lucky Draw Image====================//
                          Image.asset(
                            'assets/images/lucky_draw_image.png',
                            width: screenSize.width * .62,
                          ),

                          SizedBox(height: screenSize.height * .024),
                          //====================Days Left Blue Container====================//
                          daysLeftContainer(context: context),

                          SizedBox(height: screenSize.height * .035),
                          //====================Count Down Timer====================//
                          countDownTimerSegment(
                            days: state.timeMap!['timeInDays']!,
                            hours: state.timeMap!['timeInHours']!,
                            minutes: state.timeMap!['timeInMinutes']!,
                            seconds: state.timeMap!['timeInSeconds']!,
                          ),

                          SizedBox(height: screenSize.height * .04),
                          //====================Gifts Segment====================//
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
                                    color: Colors.black.withOpacity(.8),
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
                                      color: Colors.black.withOpacity(.8),
                                      fontSize: screenSize.width * .031,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenSize.height * .012),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * .05,
                            ),
                            child: giftBoxesSegment(context),
                          ),
                        ],
                      )
                    ],
                  );
                } else {
                  return RefreshIndicator.adaptive(
                    onRefresh: () async {
                      luckyDrawBloc.add(LuckyDrawLoadEvent());
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: screenSize.height * .25),
                            Lottie.asset(
                              'assets/lottie/no_data_animation.json',
                              width: screenSize.width * .65,
                            ),
                            Text(
                              'No Lucky Draw Available at the moment',
                              style: GoogleFonts.inter(
                                fontSize: screenSize.width * .041,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(.75),
                                height: .1,
                              ),
                            ),
                            SizedBox(height: screenSize.height * .1)
                          ],
                        ),
                      ),
                    ),
                  );
                }
              case LuckyDrawWinnersDisplayState():
                return Container();
            }
          },
        ),
      ),
    );
  }
}
