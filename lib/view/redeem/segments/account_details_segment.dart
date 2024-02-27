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
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  accountDetailsRow(
                    key: 'Account Name',
                    value: bankDetails!.accountName ?? '',
                    spacing: screenSize.width * .12,
                  ),
                  SizedBox(height: screenSize.height * .013),
                  accountDetailsRow(
                    key: 'Account Number',
                    value: bankDetails.accountNo ?? '',
                    spacing: screenSize.width * .08,
                  ),
                  SizedBox(height: screenSize.height * .013),
                  accountDetailsRow(
                    key: 'IFSC Code',
                    value: bankDetails.ifsc ?? '',
                    spacing: screenSize.width * .19,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
