import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/points/points_bloc.dart';
import 'package:turning_point/utils/screen_size.dart';

Widget bannerSegment() {
  return Stack(
    children: [
      Positioned(
        top: 4,
        left: screenSize.width * .02,
        child: Container(
          width: screenSize.width * .33,
          height: screenSize.width * .33,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -1),
                color: Color.fromRGBO(72, 72, 72, 0.04),
              ),
              BoxShadow(
                offset: Offset(0, 5),
                color: Color.fromRGBO(177, 177, 177, 0.25),
                blurStyle: BlurStyle.inner,
              ),
              BoxShadow(
                color: Color.fromRGBO(247, 247, 247, 1),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        bottom: 5,
        right: -screenSize.height * .06,
        child: Container(
          width: screenSize.height * .2,
          height: screenSize.height * .2,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(247, 247, 247, 1),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 1),
                color: Color.fromRGBO(72, 72, 72, 0.04),
              ),
              BoxShadow(
                offset: Offset(-5, -5),
                color: Color.fromRGBO(177, 177, 177, 0.25),
                blurStyle: BlurStyle.inner,
              ),
              BoxShadow(
                color: Color.fromRGBO(247, 247, 247, 1),
              ),
            ],
          ),
        ),
      ),
      Column(
        children: [
          Container(
            width: double.infinity,
            height: screenSize.height * .19,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * .065),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'WIN BIG!',
                        style: GoogleFonts.poppins(
                          fontSize: screenSize.width * .051,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: screenSize.height * .008),
                      Text(
                        'Win Prizes by participating in\nContests',
                        style: GoogleFonts.poppins(
                          color: const Color.fromRGBO(0, 90, 143, 1),
                          fontSize: screenSize.width * .035,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: -4,
                  bottom: 0,
                  child: Image.asset(
                    'assets/images/contest_banner_image.png',
                    width: screenSize.width * .5,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: screenSize.height * .01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Available Points : ',
                style: GoogleFonts.roboto(
                  color: const Color.fromRGBO(0, 99, 255, 1),
                  fontSize: screenSize.width * .03,
                  fontWeight: FontWeight.w500,
                ),
              ),
              BlocBuilder<PointsBloc, PointsState>(
                builder: (context, pointsState) {
                  return Text(
                    pointsState.points.toString(),
                    style: GoogleFonts.roboto(
                      color: const Color.fromRGBO(255, 152, 0, 1),
                      fontSize: screenSize.width * .032,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
