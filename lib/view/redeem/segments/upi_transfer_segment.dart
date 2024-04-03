part of '../redeem_screen.dart';

Widget upiTransferSegment({required TextEditingController upiController}) {
  return BlocBuilder<ProfileBloc, ProfileState>(
    builder: (context, state) {
      // final bool status = state.userModel!.bankDetails != null &&
      //     state.userModel!.bankDetails!.isNotEmpty;
      return Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * .061),
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
                            final status = redeemState.isTermsAgreed &&
                                redeemState.redeemPoints <=
                                    pointsBloc.state.points! &&
                                upiController.text.isNotEmpty;
                            return GestureDetector(
                              onTap: () {
                                if (status) {
                                  if (profileBloc
                                              .state.userModel!.bankDetails !=
                                          null &&
                                      profileBloc.state.userModel!.bankDetails!
                                          .isNotEmpty) {
                                    redeemBloc.add(RedeemButtonPressedEvent(
                                        upiId: upiController.text));
                                  } else {
                                    showAnimatedGenericDialog(
                                      context: context,
                                      iconPath:
                                          'assets/icons/kyc_declined_icon.png',
                                      title: 'KYC Not Updated',
                                      content:
                                          'Please update your KYC to avail the feature',
                                      buttonTitle: 'OK',
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
      );
    },
  );
}
