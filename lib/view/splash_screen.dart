import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
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
  @override
  void initState() {
    clearCache();
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        isLoaded = true;
      });
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
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
          child: AnimatedScale(
            scale: isLoaded ? 2 : 1,
            duration: const Duration(milliseconds: 1000),
            child: Image.asset(
              'assets/images/splash_logo.png',
              width: screenSize.width * .25,
            ),
          ),
        ),
      ),
    );
  }
}
