import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/lucky_draw/lucky_draw_bloc.dart';
import 'package:turning_point/helper/custom_navigator.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_loading.dart';
import 'package:turning_point/view/lucky_draw/all_gifts_screen.dart';
import 'package:turning_point/view/lucky_draw/segments/count_down_timer_segment.dart';
import 'package:turning_point/view/lucky_draw/segments/days_left_container.dart';
import 'package:turning_point/view/lucky_draw/segments/gift_boxes_segment.dart';

class LuckyDrawScreen extends StatefulWidget {
  const LuckyDrawScreen({super.key});

  @override
  State<LuckyDrawScreen> createState() => _LuckyDrawScreenState();
}

class _LuckyDrawScreenState extends State<LuckyDrawScreen> {
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
                return spinningLinesLoading(color: Colors.white);
              case LuckyDrawLoadedState():
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
                    //====================Lucky Draw Image====================//
                    Positioned(
                      top: screenSize.height * .045,
                      child: Image.asset(
                        'assets/images/lucky_draw_image.png',
                        width: screenSize.width * .7,
                      ),
                    ),

                    //====================Days Left Blue Container====================//
                    Positioned(
                      top: screenSize.height * .33,
                      child: daysLeftContainer(
                          daysLeft: state.timeMap!['timeInDays']!),
                    ),

                    //====================Count Down Timer====================//
                    Positioned(
                      top: screenSize.height * .42,
                      child: countDownTimerSegment(
                        days: state.timeMap!['timeInDays']!,
                        hours: state.timeMap!['timeInHours']!,
                        minutes: state.timeMap!['timeInMinutes']!,
                        seconds: state.timeMap!['timeInSeconds']!,
                      ),
                    ),

                    //====================Gifts Segment====================//
                    Positioned(
                      top: screenSize.height * .555,
                      left: screenSize.width * .075,
                      child: Text(
                        'Gifts',
                        style: GoogleFonts.roboto(
                          color: Colors.black.withOpacity(.8),
                          fontSize: screenSize.width * .036,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Positioned(
                      top: screenSize.height * .56,
                      right: screenSize.width * .075,
                      child: GestureDetector(
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
                    ),
                    Positioned(
                      bottom: screenSize.height * .025,
                      child: giftBoxesSegment(),
                    )
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
