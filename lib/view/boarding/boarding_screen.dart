import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/boarding/segments/boarding_screen_content.dart';
import 'package:turning_point/view/home/home_screen.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: -screenSize.width * .22,
            left: -screenSize.width * .15,
            child: Container(
              width: screenSize.width * .74,
              height: screenSize.width * .74,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(247, 247, 247, 1),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(177, 177, 177, 0.04),
                    offset: Offset(41, 4),
                    blurRadius: 4,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * .4,
            right: -screenSize.width * .1,
            child: Container(
              width: screenSize.width * .48,
              height: screenSize.width * .48,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(247, 247, 247, 1),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(177, 177, 177, 0.04),
                    offset: Offset(41, 4),
                    blurRadius: 4,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   top: screenSize.height * .13,
          //   child: boardingScreenContentSegment(
          //     title: 'PLAY LUCKY DRAW',
          //     imagePath: 'assets/images/play_lucky_draw_boarding.png',
          //     content:
          //         'It is a long established fact that a reader will be distracted\nby the readable content of a page when looking at its\nlayout.',
          //   ),
          // ),

          PageView(
            controller: _pageController,
            children: [
              boardingScreenContent(
                title: 'EARN POINTS',
                subTitle: 'GET REWARDS',
                imagePath: 'assets/images/earn_rewards_boarding.png',
                imageWidth: screenSize.width * .52,
                content:
                    'It is a long established fact that a reader will be distracted\nby the readable content of a page when looking at its\nlayout.',
                imageSpacing: screenSize.height * .012,
              ),
              boardingScreenContent(
                title: 'EARN POINTS',
                subTitle: 'GET DISCOUNTS ON SHOP',
                imagePath: 'assets/images/shop_discount_boarding.png',
                imageWidth: screenSize.width * .84,
                content:
                    'It is a long established fact that a reader will be distracted\nby the readable content of a page when looking at its\nlayout.',
                imageSpacing: screenSize.height * .05,
              ),
              boardingScreenContent(
                title: 'PARTICIPATE IN LUCKY DRAW',
                imagePath: 'assets/images/play_lucky_draw_boarding.png',
                imageWidth: screenSize.width * .76,
                content:
                    'It is a long established fact that a reader will be distracted\nby the readable content of a page when looking at its\nlayout.',
              ),
            ],
          ),
          Positioned(
            bottom: screenSize.height * .08,
            child: GestureDetector(
              onTap: () {
                if (_pageController.page! < 2) {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear);
                } else {
                  Navigator.of(context).pushReplacement(
                    PageTransition(
                      child: const HomeScreen(),
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 750),
                    ),
                  );
                }
              },
              child: Container(
                width: screenSize.width * .37,
                height: screenSize.width * .11,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color.fromRGBO(0, 99, 255, 1),
                ),
                child: Center(
                  child: Text(
                    'Next',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .031,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
