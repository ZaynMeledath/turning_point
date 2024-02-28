part of '../redeem_screen.dart';

Widget upiTransferSegment({required TextEditingController upiController}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .061),
    child: Column(
      children: [
//====================Points Field where points can be changed using + and - buttons====================//
        redeemPointsFieldSegment(),
        SizedBox(height: screenSize.height * .04),

//====================Amount in Rupees Segment====================//
        yourAmountSegment(),
        SizedBox(height: screenSize.height * .03),

//====================Title====================//
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Enter Your UPI ID',
            style: GoogleFonts.roboto(
              fontSize: screenSize.width * .041,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: screenSize.height * .01),

//====================UPI TextField====================//
        Container(
            width: double.infinity,
            height: screenSize.width * .1,
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * .041),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(-1.5, 1.5),
                  blurRadius: 1,
                  color: Color.fromRGBO(0, 0, 0, .25),
                ),
                BoxShadow(
                  offset: Offset(1.5, -.5),
                  blurRadius: 1,
                  color: Color.fromRGBO(0, 0, 0, .25),
                ),
              ],
            ),
            child: Center(
              child: TextFormField(
                controller: upiController,
                style: GoogleFonts.inter(
                  fontSize: screenSize.width * .031,
                ),
                decoration: InputDecoration(
                  hintText: 'UPI ID',
                  hintStyle: GoogleFonts.inter(
                    fontSize: screenSize.width * .031,
                  ),
                  border: InputBorder.none,
                ),
              ),
            )),
        SizedBox(height: screenSize.height * .03),

//====================Agree Terms Segment====================//
        agreeTermsSegment(),

        SizedBox(height: screenSize.height * .035),

//====================Submit Button====================//
        BlocBuilder<RedeemBloc, RedeemState>(
          builder: (context, redeemState) {
            final status = redeemState.isTermsAgreed &&
                redeemState.redeemPoints <= pointsBloc.state.points! &&
                upiController.text.isNotEmpty;
            return GestureDetector(
              onTap: () {
                if (status) {
                  if (profileBloc.state.userModel!.bankDetails != null &&
                      profileBloc.state.userModel!.bankDetails!.isNotEmpty) {
                    redeemBloc.add(
                        RedeemButtonPressedEvent(upiId: upiController.text));
                  } else {
                    showAnimatedGenericDialog(
                      context: context,
                      iconPath: 'assets/icons/kyc_declined_icon.png',
                      title: 'KYC Not Updated',
                      content: 'Please update your KYC to avail the feature',
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
    ),
  );
}
