// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/dialog/show_animated_generic_dialog.dart';
import 'package:turning_point/utils/custom_navigator.dart';
import 'package:turning_point/utils/flight_shuttle.dart';
import 'package:turning_point/utils/screen_size.dart';
import 'package:turning_point/view/signin/sign_in_screen.dart';

class FirstBoardingScreen extends StatefulWidget {
  const FirstBoardingScreen({super.key});

  @override
  State<FirstBoardingScreen> createState() => _FirstBoardingScreenState();
}

class _FirstBoardingScreenState extends State<FirstBoardingScreen> {
  bool isLoaded = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 300), () {
      Future.delayed(Duration.zero, () {
        setState(() {
          isLoaded = true;
        });
      });
    });
    checkNetworkConnection();
    super.initState();
  }

  void checkNetworkConnection() async {
    dynamic result;
    Timer.run(() async {
      result = await InternetAddress.lookup('google.com');
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      if (result == null) {
        showAnimatedGenericDialog(
          context: context,
          iconPath: 'assets/lottie/no_internet_animation.json',
          title: 'No Internet Connection',
          content: 'Check your connectivity status and try again',
          buttons: {'OK': null},
          iconWidth: screenSize.width * .25,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
//====================Background Image====================//
          Hero(
            tag: 'login_screen_image',
            child: Image.asset(
              'assets/images/login_screen_image.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

//====================Half Screen Sized Black Container====================//
          Align(
            alignment: Alignment.bottomCenter,
            child: Hero(
              tag: 'login_black_container',
              child: Container(
                height: screenSize.height / 2 - screenSize.height * .07,
                color: Colors.black.withOpacity(.8),
              ),
            ),
          ),
//====================Logo====================//
          Positioned(
            bottom: screenSize.height * .475,
            child: Hero(
              tag: 'turning_point_logo',
              child: Image.asset(
                'assets/images/logo_group_horizontal.png',
                width: screenSize.width * .82,
                height: screenSize.height * .18,
              ),
            ),
          ),

//====================Text Segment====================//
          Positioned(
            bottom: screenSize.height * .34,
            child: AnimatedOpacity(
              opacity: isLoaded ? 1 : 0,
              duration: const Duration(milliseconds: 1200),
              child: Text(
                'Watch and Earn!',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: screenSize.width * .08,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: screenSize.height * .3,
            child: Hero(
              tag: 'login_subtitle',
              flightShuttleBuilder: flightShuttleBuilder,
              child: Text(
                'Here you can make your time into money!',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: screenSize.width * .04,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),

//====================Get Started Button====================//
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                CustomNavigator.push(
                  context: context,
                  child: const SignInScreen(),
                );
              },
              child: Hero(
                tag: 'sign_in_sign_up_container',
                flightShuttleBuilder: flightShuttleBuilder,
                child: Container(
                  width: screenSize.width * .28,
                  height: screenSize.width * .12,
                  margin: EdgeInsets.only(
                    bottom: screenSize.height * .11,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromRGBO(52, 110, 241, 1),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 1,
                        color: Color.fromRGBO(0, 0, 0, .17),
                      ),
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 1,
                        color: Color.fromRGBO(0, 0, 0, .08),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Get Started',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .035,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
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
