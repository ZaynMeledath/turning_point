part of '../redeem_screen.dart';

Widget bankTransferSegment({required BuildContext context}) {
  return BlocBuilder<ProfileBloc, ProfileState>(
    builder: (context, state) {
      // final bool status = state.userModel!.bankDetails != null &&
      //     state.userModel!.bankDetails!.isNotEmpty;
      return Expanded(
        child: SizedBox(
          child: LiquidPullToRefresh(
            onRefresh: () => _handleRefresh(),
            animSpeedFactor: 2,
            height: 50,
            showChildOpacityTransition: false,
            color: const Color(0xFFFFD700),
            backgroundColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * .05),
              child: ListView(
                children: [
                  //====================Points Field where points can be changed using + and - buttons====================//
                  redeemPointsFieldSegment(),
                  SizedBox(height: screenSize.height * .04),

                  //====================Amount in Rupees Segment====================//
                  yourAmountSegment(),
                  SizedBox(height: screenSize.height * .03),

                  state.userModel!.kycStatus == KycStatus.APPROVED
                      ? Column(
                          children: [
                            //====================Account Details Segment====================//

                            accountDetailsSegment(
                                state.userModel!.bankDetails![0]),

                            SizedBox(height: screenSize.height * .03),

                            //====================Agree Terms Segment====================//
                            agreeTermsSegment(),
                            SizedBox(height: screenSize.height * .02),

                            //====================Submit Button====================//
                            BlocBuilder<RedeemBloc, RedeemState>(
                              builder: (context, redeemState) {
                                final status = redeemState.isTermsAgreed &&
                                    redeemState.redeemPoints <=
                                        pointsBloc.state.points!;
                                return GestureDetector(
                                  onTap: () {
                                    if (status) {
                                      showAnimatedGenericDialog(
                                        context: context,
                                        iconPath:
                                            'assets/lottie/coin_animation.json',
                                        title: 'Redeem',
                                        content:
                                            'Are you sure you want to redeem ${redeemState.redeemPoints} points?',
                                        buttons: {
                                          'Cancel': () =>
                                              Navigator.pop(context),
                                          'Redeem': () {
                                            redeemBloc.add(
                                                RedeemButtonPressedEvent());
                                            Navigator.pop(context);
                                          },
                                        },
                                      );
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.width * .1,
                                      vertical: screenSize.width * .03,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: status
                                          ? const Color.fromRGBO(0, 99, 255, 1)
                                          : Colors.grey,
                                    ),
                                    child: Text(
                                      'Submit',
                                      style: GoogleFonts.inter(
                                        fontSize: screenSize.width * .031,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: screenSize.height * .019),
                          ],
                        )
                      : Text(
                          'Bank Transfer will be enabled after\nverifying your KYC',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: screenSize.width * .034,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
