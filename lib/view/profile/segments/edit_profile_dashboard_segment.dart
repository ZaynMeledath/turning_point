import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turning_point/view/edit_profile/edit_profile_screen.dart';

//====================To make the text Hero animation smooth====================//
Widget flightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  return DefaultTextStyle(
    style: DefaultTextStyle.of(toHeroContext).style,
    child: toHeroContext.widget,
  );
}

Widget editProfileDashboardSegment(
    {required BuildContext context, required Size screenSize}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .046),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
//====================Edit Profile Container====================//
        GestureDetector(
          onTap: () => Navigator.of(context).push(
            PageTransition(
              child: const EditProfileScreen(),
              duration: const Duration(milliseconds: 350),
              reverseDuration: const Duration(milliseconds: 350),
              type: PageTransitionType.rightToLeft,
            ),
          ),
          child: Container(
            width: screenSize.width * .419,
            height: screenSize.height * .041,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Color.fromRGBO(184, 184, 184, .2),
                Color.fromRGBO(239, 239, 239, .3),
                Color.fromRGBO(184, 184, 184, .2),
              ]),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Hero(
                tag: 'edit_profile',
                flightShuttleBuilder: flightShuttleBuilder,
                child: Text(
                  'Edit Profile',
                  style: GoogleFonts.roboto(
                    fontSize: screenSize.width * .036,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),

//====================Dashboard Container====================//
        Container(
          width: screenSize.width * .419,
          height: screenSize.height * .041,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(184, 184, 184, .2),
              Color.fromRGBO(239, 239, 239, .3),
              Color.fromRGBO(184, 184, 184, .2),
            ]),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              'Dashboard',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .036,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
