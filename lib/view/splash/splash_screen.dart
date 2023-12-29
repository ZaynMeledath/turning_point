import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/boarding/first_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoaded = false;
  bool startFadeInAnimation = false;
  @override
  void initState() {
    clearCache();

    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        startFadeInAnimation = true;
      });
    });

    Future.delayed(const Duration(milliseconds: 1800), () {
      setState(() {
        isLoaded = true;
      });
    });

    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.of(context).pushReplacement(PageTransition(
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 1000),
        child: const FirstBoardingScreen(),
        curve: Curves.linear,
      ));
    });

    super.initState();
  }

  void clearCache() async {
    await DefaultCacheManager().emptyCache();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                opacity: startFadeInAnimation ? 1 : 0,
                duration: const Duration(milliseconds: 800),
                child: AnimatedScale(
                  scale: isLoaded ? 2 : 1,
                  duration: const Duration(milliseconds: 1000),
                  child: Image.asset(
                    'assets/images/splash_logo.png',
                    width: screenSize.width * .28,
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * .014),
              AnimatedOpacity(
                opacity: startFadeInAnimation ? 1 : 0,
                duration: const Duration(milliseconds: 800),
                child: AnimatedOpacity(
                  opacity: isLoaded ? 0 : 1,
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    'FURNIPART',
                    style: GoogleFonts.poppins(
                      letterSpacing: 4,
                      color: const Color.fromRGBO(239, 64, 68, 1),
                      fontSize: screenSize.width * .05,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
