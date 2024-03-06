part of '../refer_screen.dart';

class ReferralInstructionContainer extends StatelessWidget {
  const ReferralInstructionContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: screenSize.width,
        height: screenSize.height * .24,
        color: const Color(0xfff7f5ff),
        padding: EdgeInsets.only(top: screenSize.height * .028),
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
                      const SizedBox(height: 20),
                      Image.asset(
                        'assets/images/smartphone 1.png',
                        width: 20,
                        height: 21,
                      ),
                      const SizedBox(height: 20),
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
                        Text('Invite your friend to register on Second Brain',
                            style: GoogleFonts.roboto(
                              color: const Color(0xff545454),
                              fontSize: screenSize.width * .031,
                              fontWeight: FontWeight.w400,
                            )),
                        SizedBox(height: screenSize.height * .023),
                        Text(
                            'When your friend register on app, both of you will\nget 100 worth reward points',
                            style: GoogleFonts.roboto(
                              color: const Color(0xff545454),
                              fontSize: screenSize.width * .031,
                              fontWeight: FontWeight.w400,
                            )),
                        SizedBox(height: screenSize.height * .023),
                        Text(
                          'Reward points can be used in subscription plan',
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
}
