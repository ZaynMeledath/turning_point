part of '../redeem_screen.dart';

Widget accountDetailsSegment(
  BankDetails? bankDetails,
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
      bankDetails != null
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: realScreenSize.width * .04,
                      vertical: realScreenSize.height * .016,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(247, 250, 252, 1),
                      // borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Account Name',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  fontSize: screenSize.width * .036,
                                  color: const Color.fromRGBO(109, 109, 109, 1),
                                ),
                              ),
                              SizedBox(height: screenSize.height * .013),
                              Text(
                                'Account Number',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  fontSize: screenSize.width * .036,
                                  color: const Color.fromRGBO(109, 109, 109, 1),
                                ),
                              ),
                              SizedBox(height: screenSize.height * .013),
                              Text(
                                'IFSC',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  fontSize: screenSize.width * .036,
                                  color: const Color.fromRGBO(109, 109, 109, 1),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: realScreenSize.width * .1),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bankDetails.accountName.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  fontSize: screenSize.width * .036,
                                  color: const Color.fromRGBO(109, 109, 109, 1),
                                ),
                              ),
                              SizedBox(height: screenSize.height * .013),
                              Text(
                                bankDetails.accountNo.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  fontSize: screenSize.width * .036,
                                  color: const Color.fromRGBO(109, 109, 109, 1),
                                ),
                              ),
                              SizedBox(height: screenSize.height * .013),
                              Text(
                                bankDetails.ifsc.toString(),
                                overflow: TextOverflow.ellipsis,
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
                  ),
                ],
              ),
            )
          : Container(
              width: realScreenSize.width * .8,
              height: screenSize.height * .15,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(247, 250, 252, 1),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
    ],
  );
}
