import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/login/segments/otp_container.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late final TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: -screenSize.width * .22,
            left: -screenSize.width * .15,
            child: Container(
              width: screenSize.width * .74,
              height: screenSize.width * .74,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(247, 247, 247, 1),
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
            top: screenSize.height * .4,
            right: -screenSize.width * .1,
            child: Container(
              width: screenSize.width * .48,
              height: screenSize.width * .48,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(247, 247, 247, 1),
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
            top: screenSize.height * .18,
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/otp_screen_image.png',
                    width: screenSize.width * .6,
                  ),
                  SizedBox(height: screenSize.height * .04),
                  Text(
                    'VERIFICATION CODE',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .051,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(29, 29, 29, 1),
                    ),
                  ),
                  SizedBox(height: screenSize.height * .011),
                  Text(
                    'Please enter the verification code sent to',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .036,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(29, 29, 29, 1),
                    ),
                  ),
                  SizedBox(height: screenSize.height * .01),
                  Text(
                    '+918181818181',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .038,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                  SizedBox(height: screenSize.height * .025),
                  Row(
                    children: [
                      otpContainer(),
                      SizedBox(width: screenSize.width * .025),
                      otpContainer(),
                      SizedBox(width: screenSize.width * .025),
                      otpContainer(),
                      SizedBox(width: screenSize.width * .025),
                      otpContainer(),
                    ],
                  ),
                  SizedBox(height: screenSize.height * .01),
                  Row(
                    children: [
                      Text(
                        "Didn't Receive the OTP? ",
                        style: GoogleFonts.roboto(
                          fontSize: screenSize.width * .031,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Resend',
                        style: GoogleFonts.roboto(
                          fontSize: screenSize.width * .035,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(0, 99, 255, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: screenSize.height * .08,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: screenSize.width * .37,
                height: screenSize.width * .11,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color.fromRGBO(0, 99, 255, 1),
                ),
                child: Center(
                  child: Text(
                    'Verify',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .031,
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
    );
  }
}
