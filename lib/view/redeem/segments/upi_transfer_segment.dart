part of '../redeem_screen.dart';

Widget upiTransferSegment() {
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
            color: const Color.fromRGBO(246, 246, 246, 1),
            borderRadius: BorderRadius.circular(6),
            boxShadow: const [
              BoxShadow(
                offset: Offset(-.5, .5),
                blurRadius: 1.5,
                color: Color.fromRGBO(0, 0, 0, .25),
              ),
            ],
          ),
        ),
        SizedBox(height: screenSize.height * .04),

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
