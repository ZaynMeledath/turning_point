part of '../redeem_screen.dart';

Widget accountDetailsSegment(
  BankDetails bankDetails,
) {
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
      SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            accountDetailsRow(
              key: 'Account Name',
              value: bankDetails.accountName ?? '',
              spacing: screenSize.width * .1,
            ),
            SizedBox(height: screenSize.height * .013),
            accountDetailsRow(
              key: 'Account Number',
              value: bankDetails.accountNo ?? '',
              spacing: screenSize.width * .06,
            ),
            SizedBox(height: screenSize.height * .013),
            accountDetailsRow(
              key: 'IFSC Code',
              value: bankDetails.ifsc ?? '',
              spacing: screenSize.width * .17,
            ),
          ],
        ),
      ),
    ],
  );
}
