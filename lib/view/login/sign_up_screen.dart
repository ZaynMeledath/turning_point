import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/login/segments/sign_up_text_field.dart';
import 'package:turning_point/view/terms_and_conditions/terms_and_conditions_screen.dart';
// part 'package:turning_point/lib/view/login/segments/sign_up_text_field_segment.dart';

class SignUpScreen extends StatefulWidget {
  final bool isContractor;
  const SignUpScreen({
    required this.isContractor,
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late bool isContractor;
  int activeRadioNumber = 1;

  late final TextEditingController mobileController;
  late final TextEditingController contractorOrBusinessController;

  @override
  void initState() {
    isContractor = widget.isContractor;
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
              SizedBox(height: screenSize.height * .17),
              Hero(
                tag: 'furnipart_logo',
                child: Image.asset(
                  'assets/images/furnipart_logo.png',
                  width: screenSize.width * .32,
                  height: screenSize.height * .086,
                ),
              ),
              SizedBox(height: screenSize.height * .07),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sign up to start\nEarning...',
                  style: GoogleFonts.roboto(
                    fontSize: screenSize.width * .08,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(16, 16, 16, 1),
                  ),
                ),
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
                      child: const TermsAndConditionsScreen(isAccepted: false),
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
                    height: screenSize.width * .14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
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
                          fontSize: screenSize.width * .036,
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
