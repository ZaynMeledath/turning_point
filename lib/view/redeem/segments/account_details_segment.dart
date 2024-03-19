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
          fontSize: screenSize.width * .045,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: screenSize.height * .02),

      //====================Account Details====================//
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: realScreenSize.width * .04,
              vertical: realScreenSize.height * .016,
            ),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(247, 250, 252, 1),
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Name',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .036,
                        color: const Color.fromRGBO(109, 109, 109, 1),
                      ),
                    ),
                    SizedBox(height: screenSize.height * .013),
                    Text(
                      'Account Number',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .036,
                        color: const Color.fromRGBO(109, 109, 109, 1),
                      ),
                    ),
                    SizedBox(height: screenSize.height * .013),
                    Text(
                      'IFSC',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .036,
                        color: const Color.fromRGBO(109, 109, 109, 1),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: realScreenSize.width * .15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bankDetails.accountName.toString(),
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .036,
                        color: const Color.fromRGBO(109, 109, 109, 1),
                      ),
                    ),
                    SizedBox(height: screenSize.height * .013),
                    Text(
                      bankDetails.accountNo.toString(),
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .036,
                        color: const Color.fromRGBO(109, 109, 109, 1),
                      ),
                    ),
                    SizedBox(height: screenSize.height * .013),
                    Text(
                      bankDetails.ifsc.toString(),
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .036,
                        color: const Color.fromRGBO(109, 109, 109, 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}
