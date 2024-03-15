import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turning_point/bloc/auth/auth_bloc.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/boarding/first_boarding_screen.dart';
import 'package:turning_point/view/home/home_screen.dart';

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
    authBloc.add(AuthInitializeEvent());
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
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is SignedInState) {
              return const HomeScreen();
            } else {
              return const FirstBoardingScreen();
            }
          },
        ),
        curve: Curves.linear,
      ));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -screenSize.width * .4,
              left: -screenSize.width * .2,
              child: Container(
                width: screenSize.width * .74,
                height: screenSize.width * .74,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(247, 247, 247, .15),
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
              top: screenSize.height * .6,
              right: -screenSize.width * .28,
              child: Container(
                width: screenSize.width * .58,
                height: screenSize.width * .58,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(247, 247, 247, .15),
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
            Center(
              child: AnimatedOpacity(
                opacity: startFadeInAnimation ? 1 : 0,
                duration: const Duration(milliseconds: 800),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/furnipart_logo_splash.png',
                      height: screenSize.height * .1,
                    ),
                    AnimatedScale(
                      scale: isLoaded ? 2 : 1,
                      duration: const Duration(milliseconds: 1000),
                      child: Image.asset(
                        'assets/images/turning_point_logo.png',
                        height: screenSize.height * .18,
                      ),
                    ),
                    Image.asset(
                      'assets/images/claart_logo.png',
                      height: screenSize.height * .1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}







//Paste these in inside a column if needed

// AnimatedOpacity(
//   opacity: startFadeInAnimation ? 1 : 0,
//   duration: const Duration(milliseconds: 1000),
//   child: AnimatedScale(
//     scale: isLoaded ? 2 : 1,
//     duration: const Duration(milliseconds: 1000),
//     child: Image.asset(
//       'assets/images/splash_logo.png',
//       width: screenSize.width * .4,
//     ),
//   ),
// ),
// AnimatedOpacity(
//   opacity: startFadeInAnimation ? 1 : 0,
//   duration: const Duration(milliseconds: 800),
//   child: AnimatedOpacity(
//     opacity: isLoaded ? 0 : 1,
//     duration: const Duration(milliseconds: 600),
//     child: Text(
//       'FURNIPART',
//       style: GoogleFonts.poppins(
//         letterSpacing: 4,
//         color: const Color.fromRGBO(239, 64, 68, 1),
//         fontSize: screenSize.width * .05,
//         fontWeight: FontWeight.w500,
//       ),
//     ),
//   ),
// ),
