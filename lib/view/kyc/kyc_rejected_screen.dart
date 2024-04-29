import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/my_app_bar.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/view/kyc/segments/kyc_submitted_details_segment.dart';

class KycRejectedScreen extends StatelessWidget {
  const KycRejectedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context: context, title: 'KYC'),
      body: SafeArea(
        child: LiquidPullToRefresh(
          onRefresh: () async {
            UserRepository.getUserById(avoidGettingFromPreference: true);
            profileBloc.add(ProfileLoadEvent());
          },
          height: 80,
          animSpeedFactor: 2,
          showChildOpacityTransition: false,
          color: const Color.fromRGBO(89, 165, 255, 1),
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Center(
              child: Column(
                children: [
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
        ),
      ),
    );
  }
}
