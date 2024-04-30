part of '../referral_screen.dart';

Widget referralInstructionContainer() {
  return Container(
      width: screenSize.width,
      height: screenSize.height * .24,
      padding: EdgeInsets.only(top: screenSize.height * .028),
      decoration: const BoxDecoration(
        color: Color(0xfff7f5ff),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 4,
            blurStyle: BlurStyle.outer,
            color: Color.fromRGBO(0, 0, 0, .1),
          ),
        ],
      ),
      child: Column(
        children: [
          Text('How Does it work',
              style: GoogleFonts.roboto(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xff263238),
              )),
          Padding(
            padding: EdgeInsets.only(left: screenSize.width * .086, top: 20),
            child: Row(
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/link 1.png',
                      width: 20,
                      height: 21,
                    ),
                    SizedBox(height: screenSize.height * .023),
                    Image.asset(
                      'assets/images/smartphone 1.png',
                      width: 20,
                      height: 21,
                    ),
                    SizedBox(height: screenSize.height * .023),
                    Image.asset(
                      'assets/images/purple_gift_box.png',
                      width: 20,
                      height: 21,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenSize.width * .051),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Invite your friend to register on Turning Point',
                          style: GoogleFonts.roboto(
                            color: const Color(0xff545454),
                            fontSize: screenSize.width * .031,
                            fontWeight: FontWeight.w400,
                          )),
                      SizedBox(height: screenSize.height * .023),
                      Text(
                          'When your friend register on app, both of you will\nget 500 reward points',
                          style: GoogleFonts.roboto(
                            color: const Color(0xff545454),
                            fontSize: screenSize.width * .031,
                            fontWeight: FontWeight.w400,
                          )),
                      SizedBox(height: screenSize.height * .023),
                      Text(
                        'Reward points can be used in In-App Purchases',
                        style: GoogleFonts.roboto(
                          color: const Color(0xff545454),
                          fontSize: screenSize.width * .031,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ));
}
