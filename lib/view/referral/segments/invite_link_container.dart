part of '../refer_screen.dart';

class InviteLinkContainer extends StatelessWidget {
  final String couponCode;

  const InviteLinkContainer({
    required this.couponCode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final message =
    //     'Join Second Brain using my Referral code and get ₹50 in your wallet: ${generateReferralLink(couponCode)}';
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
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
          SizedBox(height: screenSize.height * .021),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * .035),
            child: GestureDetector(
              onTap: () {
                // Share.share(message);
              },
              child: Container(
                  width: double.infinity,
                  height: screenSize.height * .05,
                  decoration: BoxDecoration(
                    color: const Color(0xff17f068),
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
            ),
          )
        ],
      ),
    );
  }

  String generateReferralLink(String referralCode) {
    String baseLink = 'https://secondbrainreferal.app.link/';
    return '$baseLink$referralCode';
  }
}
