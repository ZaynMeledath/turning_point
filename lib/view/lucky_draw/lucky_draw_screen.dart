import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/custom_navigator.dart';
import 'package:turning_point/helper/screen_size.dart';
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
  Timer? timer;

  int seconds = 4320000;
  int timeInSeconds = 0;
  int timeInMinutes = 0;
  int timeInHours = 0;
  int timeInDays = 0;

  Map<String, String> time = {
    'timeInSeconds': '00',
    'timeInMinutes': '00',
    'timeInHours': '00',
    'timeInDays': '00',
  };

  @override
  void initState() {
    updateTimer();
    super.initState();
  }

  void updateTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        seconds--;
      });
      formatTime();
    });
  }

  void resetTimer() {
    timer?.cancel();
  }

  void formatTime() {
    setState(() {
      timeInSeconds = (seconds % 60);
      timeInMinutes = (seconds ~/ 60) % 60;
      timeInHours = (seconds ~/ 3600) % 24;
      timeInDays = (seconds ~/ 86400);
    });

    // return '${timeInDays.toString().padLeft(2, '0')} : ${timeInHours.toString().padLeft(2, '0')} : ${timeInMinutes.toString().padLeft(2, '0')} : ${timeInSeconds.toString().padLeft(2, '0')}';
    time = {
      'timeInSeconds': timeInSeconds.toString().padLeft(2, '0'),
      'timeInMinutes': timeInMinutes.toString().padLeft(2, '0'),
      'timeInHours': timeInHours.toString().padLeft(2, '0'),
      'timeInDays': timeInDays.toString().padLeft(2, '0'),
    };
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 204, 0, 1),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
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
              child: daysLeftContainer(),
            ),

//====================Count Down Timer====================//
            Positioned(
              top: screenSize.height * .42,
              child: countDownTimerSegment(
                days: time['timeInDays']!,
                hours: time['timeInHours']!,
                minutes: time['timeInMinutes']!,
                seconds: time['timeInSeconds']!,
              ),
            ),

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
        ),
      ),
    );
  }
}