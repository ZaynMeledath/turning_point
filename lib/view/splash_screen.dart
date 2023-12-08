import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turning_point/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoaded = false;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        isLoaded = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.of(context).push(PageTransition(
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 1000),
        child: const LoginScreen(),
        curve: Curves.linear,
      ));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        opacity: isLoaded ? 1 : 0,
        duration: const Duration(milliseconds: 1200),
        child: Center(
          child: Image.asset('assets/images/splash_screen_logos.png'),
        ),
      ),
    );
  }
}
