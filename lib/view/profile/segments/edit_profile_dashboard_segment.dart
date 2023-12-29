import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/custom_navigator.dart';
import 'package:turning_point/helper/flight_shuttle.dart';
import 'package:turning_point/view/dashboard/dashboard_screen.dart';
import 'package:turning_point/view/edit_profile/edit_profile_screen.dart';

//====================To make the text Hero animation smooth====================//

Widget editProfileDashboardSegment(
    {required BuildContext context, required Size screenSize}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .046),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
//====================Edit Profile Container====================//
        GestureDetector(
          onTap: () => CustomNavigator.push(
            context: context,
            child: const EditProfileScreen(),
          ),
          child: Container(
            width: screenSize.width * .419,
            height: screenSize.width * .09,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Color.fromRGBO(184, 184, 184, .2),
                Color.fromRGBO(239, 239, 239, .3),
                Color.fromRGBO(184, 184, 184, .2),
              ]),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Hero(
                tag: 'Edit Profile',
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
        GestureDetector(
          onTap: () => CustomNavigator.push(
            context: context,
            child: const DashBoardScreen(),
          ),
          child: Container(
            width: screenSize.width * .419,
            height: screenSize.width * .09,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Color.fromRGBO(184, 184, 184, .2),
                Color.fromRGBO(239, 239, 239, .3),
                Color.fromRGBO(184, 184, 184, .2),
              ]),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Hero(
                tag: 'Dashboard',
                flightShuttleBuilder: flightShuttleBuilder,
                child: Text(
                  'Dashboard',
                  style: GoogleFonts.roboto(
                    fontSize: screenSize.width * .036,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
