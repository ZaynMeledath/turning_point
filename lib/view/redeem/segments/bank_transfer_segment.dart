part of '../redeem_screen.dart';

Widget bankTransferSegment({required BuildContext context}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .061),
    child: Column(
      children: [
//====================Points Field where points can be changed using + and - buttons====================//
        redeemPointsFieldSegment(),
        SizedBox(height: screenSize.height * .03),

//====================Amount in Rupees Segment====================//
        yourAmountSegment(),
        SizedBox(height: screenSize.height * .02),

//====================Account Details Segment====================//
        accountDetailsSegment(),
        SizedBox(height: screenSize.height * .03),

//====================Agree Terms Segment====================//
        agreeTermsSegment(),
        SizedBox(height: screenSize.height * .02),

//====================Submit Button====================//
        Container(
          width: screenSize.width * .369,
          height: screenSize.width * .115,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color.fromRGBO(0, 99, 255, 1),
          ),
          child: Center(
            child: Text(
              'SUBMIT',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .041,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
