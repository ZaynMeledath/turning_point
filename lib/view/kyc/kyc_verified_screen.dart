import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/constants/constants.dart';
import 'package:turning_point/utils/screen_size.dart';
import 'package:turning_point/utils/widget/my_app_bar.dart';
import 'package:turning_point/view/kyc/kyc_submitted_screen.dart';
import 'package:turning_point/view/kyc/segments/kyc_submitted_details_segment.dart';

class KycVerifiedScreen extends StatelessWidget {
  const KycVerifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.userModel!.kycStatus == KycStatus.SUBMITTED) {
          return const KycSubmittedScreen();
        } else {
          return Scaffold(
            appBar: myAppBar(context: context, title: 'KYC'),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: screenSize.height * .005),
                    Lottie.asset(
                      'assets/lottie/kyc_verified_animation.json',
                      width: screenSize.width * .3,
                    ),
                    Text(
                      'KYC Verified',
                      style: GoogleFonts.inter(
                        fontSize: screenSize.width * .04,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(16, 24, 40, 1),
                      ),
                    ),
                    SizedBox(height: screenSize.height * .012),
                    Text(
                      'Congratulations! Your KYC Details Have Been\nSuccessfully Verified',
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
      },
    );
  }
}
