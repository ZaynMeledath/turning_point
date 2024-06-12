import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/utils/screen_size.dart';
import 'package:turning_point/utils/widget/my_app_bar.dart';

class KycPendingScreen extends StatelessWidget {
  const KycPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context: context, title: 'KYC'),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: screenSize.height * .2),
            Image.asset(
              'assets/icons/kyc_pending_icon.png',
              width: screenSize.width * .26,
            ),
            SizedBox(height: screenSize.height * .018),
            Text(
              'Pending',
              style: GoogleFonts.inter(
                fontSize: screenSize.width * .048,
                fontWeight: FontWeight.w600,
                color: const Color.fromRGBO(16, 24, 40, 1),
              ),
            ),
            SizedBox(height: screenSize.height * .012),
            Text(
              'Your KYC details have been successfully\nsubmitted. We will notify you once they are\nverified',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: screenSize.width * .036,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(102, 112, 133, 1),
              ),
            ),
            SizedBox(height: screenSize.height * .05),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
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
            ),
          ],
        ),
      ),
    );
  }
}
