part of '../profile_screen.dart';

Widget referAndEarnContainer({required BuildContext context}) {
  return SizedBox(
    height: screenSize.height * .067,
    width: double.infinity,
    child: GestureDetector(
      onTap: () {
        CustomNavigator.push(
          context: context,
          child: const ReferScreen(),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: screenSize.height * .067,
            margin: EdgeInsets.symmetric(horizontal: screenSize.width * .06),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(235, 241, 250, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                SizedBox(width: screenSize.width * .18),
                Text(
                  'Refer friends and earn ₹500\nCashback',
                  style: GoogleFonts.poppins(
                    fontSize: screenSize.width * .03,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(0, 84, 180, 1),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: screenSize.width * .16,
                      height: screenSize.width * .055,
                      margin: EdgeInsets.only(right: screenSize.width * .03),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 84, 180, 1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          'Invite',
                          style: GoogleFonts.roboto(
                            fontSize: screenSize.width * .03,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: screenSize.width * .05,
            child: Image.asset(
              'assets/icons/refer_a_friend_icon.png',
              width: screenSize.width * .16,
            ),
          ),
        ],
      ),
    ),
  );
}
