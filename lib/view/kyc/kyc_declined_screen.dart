import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_app_bar.dart';

class KycDeclinedScreen extends StatelessWidget {
  const KycDeclinedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            customAppBar(context: context, title: 'KYC'),
            SizedBox(height: screenSize.height * .2),
            Image.asset(
              'assets/icons/kyc_declined_icon.png',
              width: screenSize.width * .26,
            ),
            SizedBox(height: screenSize.height * .018),
            Text(
              'Oops!',
              style: GoogleFonts.inter(
                fontSize: screenSize.width * .048,
                fontWeight: FontWeight.w600,
                color: const Color.fromRGBO(16, 24, 40, 1),
              ),
            ),
            SizedBox(height: screenSize.height * .012),
            Text(
              'There seems to be an issue with your\nsubmission. Please review your KYC details\nand make any necessary updates',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: screenSize.width * .036,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(102, 112, 133, 1),
              ),
            ),
            SizedBox(height: screenSize.height * .05),
            Container(
              width: screenSize.width * .8,
              height: screenSize.height * .05,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 99, 255, 1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  'Go Back',
                  style: GoogleFonts.roboto(
                    fontSize: screenSize.width * .036,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
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
