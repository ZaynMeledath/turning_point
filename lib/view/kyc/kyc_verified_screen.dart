import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_app_bar.dart';
import 'package:turning_point/view/kyc/segments/kyc_submitted_details_segment.dart';

class KycVerifiedScreen extends StatelessWidget {
  const KycVerifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              customAppBar(context: context, title: 'KYC'),
              SizedBox(height: screenSize.height * .015),
              // DottedLine(
              //   lineLength: realScreenSize.width * .95,
              //   dashGradient: const [
              //     Colors.green,
              //     Colors.blue,
              //   ],
              // ),
              Lottie.asset(
                'assets/lottie/kyc_verified_animation.json',
                width: screenSize.width * .3,
              ),
              Text(
                'Verified',
                style: GoogleFonts.inter(
                  fontSize: screenSize.width * .048,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(16, 24, 40, 1),
                ),
              ),
              SizedBox(height: screenSize.height * .012),
              Text(
                'Congratulations! Your KYC Details Have Been\nSuccessfully Verified',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: screenSize.width * .036,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(102, 112, 133, 1),
                ),
              ),
              SizedBox(height: screenSize.height * .028),
              // Container(
              //   width: screenSize.width * .8,
              //   height: screenSize.height * .05,
              //   decoration: BoxDecoration(
              //     color: const Color.fromRGBO(0, 99, 255, 1),
              //     borderRadius: BorderRadius.circular(6),
              //   ),
              //   child: Center(
              //     child: Text(
              //       'Go Back',
              //       style: GoogleFonts.roboto(
              //         fontSize: screenSize.width * .036,
              //         fontWeight: FontWeight.w600,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),

              // DottedLine(
              //   lineLength: realScreenSize.width * .95,
              //   dashGradient: const [
              //     Colors.green,
              //     Colors.blue,
              //   ],
              // ),

              // SizedBox(height: screenSize.height * .02),

              kycSubmittedDetailsSegment(context: context),
            ],
          ),
        ),
      ),
    );
  }
}
