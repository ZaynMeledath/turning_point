part of '../referral_screen.dart';

Widget inviteLinkContainer({required String referralCode}) {
  final message =
      'Check out the new Turning Point app and earn ₹100 when you register using this referral code: TP5485397944. Sign up now and unlock exclusive benefits!\n\nReferral Code : $referralCode';
  return Padding(
    padding: EdgeInsets.only(bottom: screenSize.height * .023),
    child: Column(
      children: [
        SizedBox(height: screenSize.height * .015),
        GestureDetector(
          onTap: () {
            Share.share(message);
          },
          child: Container(
              width: double.maxFinite,
              height: screenSize.height * .055,
              margin: EdgeInsets.symmetric(horizontal: screenSize.width * .05),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff0062D1),
                    Color(0xff023A79),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/share_icon.png',
                    width: screenSize.width * .045,
                  ),
                  SizedBox(width: screenSize.width * .025),
                  Text(
                    'Invite via share link',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: screenSize.width * .035,
                      fontWeight: FontWeight.w500,
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
