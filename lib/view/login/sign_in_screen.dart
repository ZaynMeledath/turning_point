import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turning_point/helper/flight_shuttle.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/login/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: screenSize.width * .075,
            right: screenSize.width * .075,
            top: screenSize.height * .046,
            bottom: screenSize.height * .023,
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: screenSize.height * .18,
                child: Hero(
                  tag: 'furnipart_logo',
                  child: Image.asset(
                    'assets/images/furnipart_logo.png',
                    width: screenSize.width * .32,
                    height: screenSize.height * .086,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: const SignUpScreen(),
                        type: PageTransitionType.rightToLeft,
                        duration: const Duration(milliseconds: 350),
                        reverseDuration: const Duration(milliseconds: 350),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'sign_in_sign_up_container',
                    flightShuttleBuilder: flightShuttleBuilder,
                    child: Container(
                      width: double.infinity,
                      height: screenSize.width * .13,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
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
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            left: screenSize.width * .1,
                            child: Image.asset(
                              'assets/icons/google_logo.png',
                              width: screenSize.width * .095,
                            ),
                          ),
                          SizedBox(width: screenSize.width * .1),
                          Text(
                            'Sign in with Google',
                            style: GoogleFonts.roboto(
                              fontSize: screenSize.width * .035,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
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
