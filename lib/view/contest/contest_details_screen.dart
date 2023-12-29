import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_app_bar.dart';
import 'package:turning_point/view/contest/segments/contest_count_down_container.dart';

class ContestDetailsScreen extends StatelessWidget {
  const ContestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            customAppBar(context: context, title: 'Contest Details'),
            SizedBox(height: screenSize.height * .01),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * .041,
              ),
              child: Stack(
                children: [
//====================Daily Contest Banner Segment====================//
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset(
                      'assets/images/daily_contest_banner.png',
                    ),
                  ),
                  Positioned(
                    left: screenSize.width * .07,
                    bottom: screenSize.width * .06,
                    child: GestureDetector(
                      onTap: () {
                        //=======Navigator goes here=======//
                      },
                      child: Container(
                        width: screenSize.width * .185,
                        height: screenSize.width * .061,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color.fromRGBO(251, 228, 2, 1),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 2,
                              color: Color.fromRGBO(196, 177, 0, 1),
                              blurStyle: BlurStyle.inner,
                            ),
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 4,
                              color: Color.fromRGBO(255, 185, 81, 1),
                              blurStyle: BlurStyle.inner,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'PLAY NOW',
                            style: GoogleFonts.poppins(
                              fontSize: screenSize.width * .028,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

//====================Contest Details Container Segment====================//
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: screenSize.height * .014,
                  horizontal: screenSize.width * .041,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * .031,
                  vertical: screenSize.width * .028,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 4,
                        color: Color.fromRGBO(0, 0, 0, .25),
                      ),
                    ]),
                child: ListView(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: screenSize.width * .03),
                            Text(
                              'Contest Name',
                              style: GoogleFonts.poppins(
                                fontStyle: FontStyle.italic,
                                fontSize: screenSize.width * .041,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromRGBO(0, 31, 36, 1),
                              ),
                            ),
                            SizedBox(height: screenSize.height * .005),
                            Row(
                              children: [
                                Text(
                                  '500',
                                  style: GoogleFonts.roboto(
                                    fontSize: screenSize.width * .08,
                                    fontWeight: FontWeight.w600,
                                    color: const Color.fromRGBO(245, 146, 0, 1),
                                  ),
                                ),
                                SizedBox(width: screenSize.width * .014),
                                Column(
                                  children: [
                                    SizedBox(height: screenSize.width * .014),
                                    Text(
                                      'Points',
                                      style: GoogleFonts.roboto(
                                        fontSize: screenSize.width * .04,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            const Color.fromRGBO(26, 26, 26, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          width: screenSize.width * .39,
                          height: screenSize.width * .39,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(255, 250, 217, 1),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: screenSize.width * .05),
                              Image.asset(
                                'assets/images/contest_details_gifts_image.png',
                                width: screenSize.width * .354,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenSize.height * .012),
                    Text(
                      'Join The Contest and Win Exciting Prizes!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: screenSize.width * .025,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    SizedBox(height: screenSize.height * .008),
                    Text(
                      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        height: 2,
                        fontSize: screenSize.width * .03,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(0, 29, 75, 1),
                      ),
                    ),
                    Text(
                      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        height: 2,
                        fontSize: screenSize.width * .03,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(0, 29, 75, 1),
                      ),
                    ),
                    Text(
                      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        height: 2,
                        fontSize: screenSize.width * .03,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(0, 29, 75, 1),
                      ),
                    ),
                    Text(
                      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        height: 2,
                        fontSize: screenSize.width * .03,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(0, 29, 75, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Time Left',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .03,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: screenSize.height * .007),
//====================Contest Count Down Timer Segment====================//
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                contestCountDownContainer(time: '03', title: 'DAYS'),
                SizedBox(width: screenSize.width * .021),
                contestCountDownContainer(time: '03', title: 'HOURS'),
                SizedBox(width: screenSize.width * .021),
                contestCountDownContainer(time: '03', title: 'MINUTES'),
                SizedBox(width: screenSize.width * .021),
                contestCountDownContainer(time: '03', title: 'SECONDS'),
              ],
            ),
            SizedBox(height: screenSize.height * .028),

//====================Enter Contest Button====================//
            Container(
              width: screenSize.width * .31,
              height: screenSize.width * .095,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color.fromRGBO(0, 99, 255, 1),
              ),
              child: Center(
                child: Text(
                  'Enter Contest',
                  style: GoogleFonts.roboto(
                    fontSize: screenSize.width * .032,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenSize.height * .025),
          ],
        ),
      ),
    );
  }
}
