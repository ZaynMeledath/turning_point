import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_radio_button.dart';
import 'package:turning_point/view/login/otp_verfication_screen.dart';
import 'package:turning_point/view/login/segments/sign_up_text_field.dart';
// part 'package:turning_point/lib/view/login/segments/sign_up_text_field_segment.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isContractor = false;
  int activeRadioNumber = 1;

  late final TextEditingController mobileController;
  late final TextEditingController contractorOrBusinessController;

  @override
  void initState() {
    mobileController = TextEditingController();
    contractorOrBusinessController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    mobileController.dispose();
    contractorOrBusinessController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * .041),
          child: Column(
            children: [
              SizedBox(height: screenSize.height * .2),
              Hero(
                tag: 'furnipart_logo',
                child: Image.asset(
                  'assets/images/furnipart_logo.png',
                  width: screenSize.width * .32,
                  height: screenSize.height * .086,
                ),
              ),
              SizedBox(height: screenSize.height * .08),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isContractor = false;
                        activeRadioNumber = 1;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customRadioButton(
                          isActive: activeRadioNumber == 1 ? true : false,
                        ),
                        SizedBox(width: screenSize.width * .01),
                        Text(
                          'Carpenter',
                          style: GoogleFonts.roboto(
                            fontSize: screenSize.width * .046,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: screenSize.width * .08),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isContractor = true;
                        activeRadioNumber = 2;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customRadioButton(
                          isActive: activeRadioNumber == 2 ? true : false,
                        ),
                        SizedBox(width: screenSize.width * .01),
                        Text(
                          'Contractor',
                          style: GoogleFonts.roboto(
                            fontSize: screenSize.width * .046,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * .02),
              signUpTextField(
                controller: mobileController,
                title: 'Mobile Number',
              ),
              SizedBox(height: screenSize.height * .03),
              signUpTextField(
                controller: contractorOrBusinessController,
                title: isContractor ? 'Business Name' : 'Contractor ID',
              ),
              SizedBox(height: screenSize.height * .05),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageTransition(
                      child: const OtpVerificationScreen(),
                      type: PageTransitionType.rightToLeft,
                      duration: const Duration(milliseconds: 350),
                      reverseDuration: const Duration(milliseconds: 350),
                    ),
                  );
                },
                child: Hero(
                  tag: 'sign_in_sign_up_container',
                  child: Container(
                    width: double.infinity,
                    height: screenSize.width * .12,
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
                    child: Center(
                      child: Text(
                        'Sign Up',
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
            ],
          ),
        ),
      ),
    );
  }
}
