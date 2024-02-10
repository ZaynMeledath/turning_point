import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:turning_point/bloc/auth/auth_bloc.dart';
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
  int currentIndex = 0;

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignedInState) {}
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            //====================Background Decoration Circles====================//
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

            //====================Pages====================//
            PageView(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              children: [
                boardingScreenContent(
                  title: 'Earn Points\nGet Reward!',
                  imagePath: 'assets/images/earn_rewards_boarding.png',
                  imageWidth: screenSize.width * .52,
                  content:
                      'It is a long established fact that a reader will be distracted\nby the readable content of a page when looking at its\nlayout.',
                  activePageNumber: 1,
                  imageSpacing: screenSize.height * .012,
                  contentSpacing: screenSize.height * .016,
                ),
                boardingScreenContent(
                  title: 'Get Discount on\non shop using Points',
                  imagePath: 'assets/images/shop_discount_boarding.png',
                  imageWidth: screenSize.width * .84,
                  content:
                      'It is a long established fact that a reader will be distracted\nby the readable content of a page when looking at its\nlayout.',
                  activePageNumber: 2,
                  imageSpacing: screenSize.height * .05,
                ),
                boardingScreenContent(
                  title: 'Lucky Draw',
                  imagePath: 'assets/images/play_lucky_draw_boarding.png',
                  imageWidth: screenSize.width * .76,
                  content:
                      'It is a long established fact that a reader will be distracted\nby the readable content of a page when looking at its\nlayout.',
                  activePageNumber: 3,
                  contentSpacing: screenSize.height * .022,
                ),
              ],
            ),

            //====================Page Indicator====================//
            Positioned(
              bottom: screenSize.height * .21,
              right: screenSize.width * .051,
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotHeight: screenSize.width * .02,
                  dotWidth: screenSize.width * .02,
                  dotColor: Colors.black,
                  activeDotColor: Colors.black,
                ),
              ),
            ),

            //====================Skip Button====================//
            Positioned(
              bottom: screenSize.height * .07,
              left: screenSize.width * .051,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    PageTransition(
                      child: const HomeScreen(),
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 750),
                    ),
                    (_) => false,
                  );
                },
                child: Text(
                  'Skip',
                  style: GoogleFonts.roboto(
                    fontSize: screenSize.width * .036,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            //====================Next/Get Started Button====================//
            Positioned(
              bottom: screenSize.height * .06,
              right: screenSize.width * .051,
              child: GestureDetector(
                onTap: () {
                  if (currentIndex < 2) {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linear);
                  } else {
                    Navigator.of(context).pushAndRemoveUntil(
                      PageTransition(
                        child: const HomeScreen(),
                        type: PageTransitionType.fade,
                        duration: const Duration(milliseconds: 750),
                      ),
                      (_) => false,
                    );
                  }
                },
                child: Container(
                  width: screenSize.width * .3,
                  height: screenSize.width * .11,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromRGBO(0, 99, 255, 1),
                  ),
                  child: Center(
                    child: Text(
                      currentIndex < 2 ? 'Next' : 'Get Started',
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
      ),
    );
  }
}
