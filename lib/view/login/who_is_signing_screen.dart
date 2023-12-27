import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/login/segments/who_is_signing_container.dart';
import 'package:turning_point/view/login/sign_up_screen.dart';

class WhoIsSigningScreen extends StatefulWidget {
  const WhoIsSigningScreen({super.key});

  @override
  State<WhoIsSigningScreen> createState() => _WhoIsSigningScreenState();
}

class _WhoIsSigningScreenState extends State<WhoIsSigningScreen> {
  bool isLoaded = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        isLoaded = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Hero(
            tag: 'login_screen_image',
            child: Image.asset(
              'assets/images/login_screen_image.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Hero(
              tag: 'login_black_container',
              child: Container(
                height: screenSize.height / 2 - screenSize.height * .075,
                // color: Colors.black.withOpacity(1),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(.7),
                      Colors.black,
                      Colors.black,
                      Colors.black,
                      Colors.black.withOpacity(.7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
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
          Positioned(
            bottom: screenSize.height * .36,
            // left: screenSize.width * .051,
            child: AnimatedOpacity(
              opacity: isLoaded ? 1 : 0,
              duration: const Duration(milliseconds: 1200),
              child: Text(
                'Who is Signing?',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: screenSize.width * .051,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: screenSize.height * .25,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * .051),
              child: AnimatedOpacity(
                opacity: isLoaded ? 1 : 0,
                duration: const Duration(milliseconds: 1200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageTransition(
                            child: const SignUpScreen(
                              isContractor: true,
                            ),
                            type: PageTransitionType.rightToLeft,
                            duration: const Duration(milliseconds: 350),
                            reverseDuration: const Duration(milliseconds: 350),
                          ),
                        );
                      },
                      child: whoIsSigningContainer(
                        title: 'Contractor',
                        imagePath: 'assets/images/contractor_avatar.png',
                      ),
                    ),
                    SizedBox(width: screenSize.width * .051),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageTransition(
                            child: const SignUpScreen(
                              isContractor: false,
                            ),
                            type: PageTransitionType.rightToLeft,
                            duration: const Duration(milliseconds: 350),
                            reverseDuration: const Duration(milliseconds: 350),
                          ),
                        );
                      },
                      child: whoIsSigningContainer(
                        title: 'Carpenter',
                        imagePath: 'assets/images/carpenter_avatar.png',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
