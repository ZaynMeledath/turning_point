part of '../referral_screen.dart';

Widget myReferralsSegment({required int totalReferrals}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .051),
    child: Column(
      children: [
        const SizedBox(height: 24),

//---------------Total Referrals---------------//
        Container(
          width: screenSize.width * .86,
          height: screenSize.height * .06,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x16000000),
                  offset: Offset(0, 1),
                  blurRadius: 4,
                )
              ]),
          child: Row(
            children: [
              SizedBox(width: screenSize.width * .02),
              Image.asset(
                'assets/images/link 1.png',
                width: screenSize.width * .07,
              ),
              SizedBox(width: screenSize.width * .03),
              Text(
                'Total Referrals',
                style: GoogleFonts.roboto(
                  fontSize: screenSize.width * .036,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff263238),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: screenSize.width * .09),
                    child: Text(totalReferrals.toString(),
                        style: GoogleFonts.roboto(
                          fontSize: screenSize.width * .05,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff0054b4),
                        )),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
