part of '../redeem_screen.dart';

Widget accountDetailsSegment() {
  return Column(
    children: [
//====================Title====================//
      Text(
        'Account Details',
        style: GoogleFonts.roboto(
          fontSize: screenSize.width * .046,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: screenSize.height * .02),

//====================Account Details====================//
      accountDetailsRow(
        key: 'Account Name',
        value: 'Turning Point',
        spacing: screenSize.width * .13,
      ),
      SizedBox(height: screenSize.height * .01),
      accountDetailsRow(
        key: 'Account Number',
        value: '523698741545',
        spacing: screenSize.width * .1,
      ),
      SizedBox(height: screenSize.height * .01),
      accountDetailsRow(
        key: 'IFSC Code',
        value: 'SBIN0003638',
        spacing: screenSize.width * .21,
      ),
    ],
  );
}
