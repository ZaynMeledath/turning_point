import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/auth/bloc/auth_bloc.dart';
import 'package:turning_point/helper/custom_navigator.dart';
import 'package:turning_point/helper/flight_shuttle.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/signin/who_is_signing_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final TextEditingController _controller;
  bool isLoaded = false;

  @override
  void initState() {
    _controller = TextEditingController();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        isLoaded = true;
      });
    });
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
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is WhoIsSigningState) {
            CustomNavigator.pushAndRemove(
              context: context,
              child: const WhoIsSigningScreen(),
            );
          }
        },
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            //====================Background Image Segment====================//
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
                tag: 'furnipart_logo',
                child: Image.asset(
                  'assets/images/logo_group_horizontal.png',
                  width: screenSize.width * .82,
                  height: screenSize.height * .18,
                ),
              ),
            ),

            //====================Text Segment====================//
            Positioned(
              bottom: screenSize.height * .29,
              child: AnimatedOpacity(
                opacity: isLoaded ? 1 : 0,
                duration: const Duration(milliseconds: 1200),
                child: Text(
                  'Create an Account now\nto Enjoy!',
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
              bottom: screenSize.height * .21,
              child: Hero(
                tag: 'login_subtitle',
                flightShuttleBuilder: flightShuttleBuilder,
                child: Text(
                  'Convert your time into money',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    color: Colors.white.withOpacity(.75),
                    fontSize: screenSize.width * .04,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),

            //====================Google Sign in Button====================//
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  context.read<AuthBloc>().add(GoogleSignInEvent());
                },
                child: Hero(
                  tag: 'sign_in_sign_up_container',
                  flightShuttleBuilder: flightShuttleBuilder,
                  child: Container(
                    width: screenSize.width * .8,
                    height: screenSize.width * .13,
                    margin: EdgeInsets.only(
                      bottom: screenSize.height * .11,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
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
                          left: screenSize.width * .09,
                          child: Image.asset(
                            'assets/icons/google_logo.png',
                            width: screenSize.width * .1,
                          ),
                        ),
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
    );
  }
}
