part of '../referral_screen.dart';

Widget inviteLinkContainer({required String couponCode}) {
  // final message =
  //     'Join Second Brain using my Referral code and get ₹50 in your wallet: ${generateReferralLink(couponCode)}';
  return Padding(
    padding: EdgeInsets.only(bottom: screenSize.height * .023),
    child: Column(
      children: [
        GestureDetector(
          child: Text('Invite via share link',
              style: GoogleFonts.roboto(
                color: const Color(0xff263238),
                fontSize: screenSize.width * .031,
                fontWeight: FontWeight.w500,
              )),
        ),
        SizedBox(height: screenSize.height * .012),
        GestureDetector(
          onTap: () {
            Share.share('Checkout the new Turning Point App!');
          },
          child: Container(
              width: double.maxFinite,
              height: screenSize.height * .05,
              margin: EdgeInsets.symmetric(horizontal: screenSize.width * .05),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(23, 230, 104, 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/whatsapp.png',
                    width: screenSize.width * .051,
                  ),
                  SizedBox(width: screenSize.width * .015),
                  Text(
                    'Invite via WhatsApp',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: screenSize.width * .034,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              )),
        )
      ],
    ),
  );
}

String generateReferralLink(String referralCode) {
  String baseLink = 'https://secondbrainreferal.app.link/';
  return '$baseLink$referralCode';
}
