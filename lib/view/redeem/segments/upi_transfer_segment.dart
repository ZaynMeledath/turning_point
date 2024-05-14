part of '../redeem_screen.dart';

Widget upiTransferSegment({required TextEditingController upiController}) {
  return BlocBuilder<ProfileBloc, ProfileState>(
    builder: (context, state) {
      // final bool redeemBloc.status = state.userModel!.bankDetails != null &&
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
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * .061),
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
                            //====================Title====================//
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenSize.width * .01),
                                child: Text(
                                  'Enter Your UPI ID',
                                  style: GoogleFonts.roboto(
                                    fontSize: screenSize.width * .041,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenSize.height * .01),

                            //====================UPI TextField====================//

                            redeemUpiTextField(upiController),

                            SizedBox(height: screenSize.height * .03),

                            //====================Agree Terms Segment====================//
                            agreeTermsSegment(),

                            SizedBox(height: screenSize.height * .035),

                            //====================Submit Button====================//
                            BlocBuilder<RedeemBloc, RedeemState>(
                              builder: (context, redeemState) {
                                redeemBloc.status = redeemState.isTermsAgreed &&
                                    redeemState.redeemPoints <=
                                        pointsBloc.state.points! &&
                                    upiController.text.isNotEmpty;
                                return GestureDetector(
                                  onTap: () {
                                    if (redeemBloc.status) {
                                      if (profileBloc.state.userModel!
                                                  .bankDetails !=
                                              null &&
                                          profileBloc.state.userModel!
                                              .bankDetails!.isNotEmpty) {
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
                                                  RedeemButtonPressedEvent(
                                                      upiId:
                                                          upiController.text));
                                              Navigator.pop(context);
                                            },
                                          },
                                        );
                                      } else {
                                        showAnimatedGenericDialog(
                                          context: context,
                                          iconPath:
                                              'assets/icons/kyc_declined_icon.png',
                                          title: 'KYC Not Updated',
                                          content:
                                              'Please update your KYC to avail the feature',
                                          buttons: {'OK': null},
                                        );
                                      }
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.width * .1,
                                      vertical: screenSize.width * .03,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: redeemBloc.status
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
                          ],
                        )
                      : Text(
                          'UPI Transfer will be enabled after\nverifying your KYC',
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
