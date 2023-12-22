import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/contest/segments/contest_count_down_container.dart';
import 'package:turning_point/view/contest/segments/contest_details_screen_app_bar.dart';

class ContestDetailsScreen extends StatelessWidget {
  const ContestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              contestDetailsScreenAppBar(context: context),
              Image.asset(
                'assets/images/contest_details_screen_image.png',
                width: screenSize.width * .61,
              ),
              // SizedBox(height: screenSize.height * .028),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: screenSize.width * .041,
                  vertical: screenSize.height * .014,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * .028,
                  vertical: screenSize.width * .03,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 249, 216, 1),
                      Color.fromRGBO(255, 249, 216, .7),
                      Color.fromRGBO(255, 255, 255, 1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Contest Name',
                      style: GoogleFonts.poppins(
                        fontSize: screenSize.width * .041,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromRGBO(83, 83, 83, 1),
                      ),
                    ),
                    SizedBox(height: screenSize.height * .012),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '500',
                          style: GoogleFonts.roboto(
                            fontSize: screenSize.width * .076,
                            fontWeight: FontWeight.w700,
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
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(26, 26, 26, 1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: screenSize.height * .016),
                    Text(
                      'Join The Contest and Win Exciting Prizes!',
                      style: GoogleFonts.poppins(
                        fontSize: screenSize.width * .025,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    SizedBox(height: screenSize.height * .015),
                    Text(
                      'It is a long established fact that a reader will be distracted\nby the readable content of a page when looking at its layout.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        height: 2,
                        fontSize: screenSize.width * .03,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(0, 29, 75, 1),
                      ),
                    ),
                    Text(
                      'It is a long established fact that a reader will be distracted\nby the readable content of a page when looking at its layout.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        height: 2,
                        fontSize: screenSize.width * .03,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(0, 29, 75, 1),
                      ),
                    ),
                    Text(
                      'It is a long established fact that a reader will be distracted\nby the readable content of a page when looking at its layout.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        height: 2,
                        fontSize: screenSize.width * .03,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(0, 29, 75, 1),
                      ),
                    ),
                    Text(
                      'It is a long established fact that a reader will be distracted\nby the readable content of a page when looking at its layout.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        height: 2,
                        fontSize: screenSize.width * .03,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(0, 29, 75, 1),
                      ),
                    ),
                    SizedBox(height: screenSize.height * .02),
                    Text(
                      'Time Left',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .03,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: screenSize.height * .007),
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
                    Container(
                      width: screenSize.width * .31,
                      height: screenSize.width * .092,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
