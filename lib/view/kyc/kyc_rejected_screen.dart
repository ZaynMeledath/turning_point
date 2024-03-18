import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_app_bar.dart';
import 'package:turning_point/view/kyc/segments/kyc_submitted_details_segment.dart';

class KycRejectedScreen extends StatelessWidget {
  const KycRejectedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              customAppBar(context: context, title: 'KYC'),
              SizedBox(height: screenSize.height * .005),
              Lottie.asset(
                'assets/lottie/kyc_rejected_animation.json',
                width: screenSize.width * .3,
              ),
              Text(
                'Oops!',
                style: GoogleFonts.inter(
                  fontSize: screenSize.width * .04,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(16, 24, 40, 1),
                ),
              ),
              SizedBox(height: screenSize.height * .012),
              Text(
                'There seems to be an issue with your\nsubmission. Please review your KYC details\nand make any necessary updates',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: screenSize.width * .031,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(102, 112, 133, 1),
                ),
              ),
              SizedBox(height: screenSize.height * .028),
              kycSubmittedDetailsSegment(context: context),
            ],
          ),
        ),
      ),
    );
  }
}
