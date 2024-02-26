part of '../redeem_screen.dart';

Widget accountDetailsSegment() {
  return BlocBuilder<ProfileBloc, ProfileState>(
    builder: (context, state) {
      final bool status = state.userModel!.bankDetails != null &&
          state.userModel!.bankDetails!.isNotEmpty;
      BankDetails? bankDetails;

      if (status) {
        bankDetails = state.userModel!.bankDetails![0];
      }
      return Visibility(
        visible: status,
        child: Column(
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
              value: bankDetails!.accountName!,
              spacing: screenSize.width * .13,
            ),
            SizedBox(height: screenSize.height * .01),
            accountDetailsRow(
              key: 'Account Number',
              value: bankDetails.accountNo!,
              spacing: screenSize.width * .1,
            ),
            SizedBox(height: screenSize.height * .01),
            accountDetailsRow(
              key: 'IFSC Code',
              value: bankDetails.ifsc!,
              spacing: screenSize.width * .21,
            ),
          ],
        ),
      );
    },
  );
}
