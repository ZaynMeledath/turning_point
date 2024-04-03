import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/constants/constants.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_app_bar.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/view/kyc/kyc_verified_screen.dart';
import 'package:turning_point/view/kyc/segments/kyc_submitted_details_segment.dart';

class KycSubmittedScreen extends StatelessWidget {
  const KycSubmittedScreen({super.key});

  Future<void> _handleRefresh() async {
    UserRepository.getUserById(avoidGettingFromPreference: true);
    profileBloc.add(ProfileLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.userModel!.kycStatus == KycStatus.APPROVED) {
          return const KycVerifiedScreen();
        } else {
          return Scaffold(
            body: SafeArea(
              child: LiquidPullToRefresh(
                height: 80,
                animSpeedFactor: 1.5,
                showChildOpacityTransition: false,
                color: const Color.fromRGBO(89, 165, 255, 1),
                backgroundColor: Colors.white,
                onRefresh: () => _handleRefresh(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      customAppBar(context: context, title: 'KYC'),
                      SizedBox(height: screenSize.height * .005),
                      Lottie.asset(
                        'assets/lottie/kyc_submitted_animation.json',
                        width: screenSize.width * .3,
                      ),
                      Text(
                        'Submitted',
                        style: GoogleFonts.inter(
                          fontSize: screenSize.width * .04,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(16, 24, 40, 1),
                        ),
                      ),
                      SizedBox(height: screenSize.height * .012),
                      Text(
                        'Your KYC details have been\nsuccessfully submitted',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: screenSize.width * .031,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(102, 112, 133, 1),
                        ),
                      ),
                      SizedBox(height: screenSize.height * .025),
                      kycSubmittedDetailsSegment(context: context),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
