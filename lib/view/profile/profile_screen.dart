import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/flight_shuttle.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/view/profile/segments/edit_profile_dashboard_segment.dart';
import 'package:turning_point/view/profile/segments/profile_options_segment.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserRepository.getUserFromPreference()!;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
//====================Header segment with Back button, Profile Picture Stack and Name====================//
            SizedBox(height: screenSize.height * .007),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Hero(
                    tag: 'back_button',
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: screenSize.width * .061,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: screenSize.height * .012),
                    Hero(
                      tag: 'profile_picture',
                      flightShuttleBuilder: flightShuttleBuilder,
                      child: CircleAvatar(
                        radius: screenSize.height * .063,
                        backgroundColor: const Color(0xffe12826),
                        child: CircleAvatar(
                          radius: (screenSize.height * .063) - 1,
                          child: CircleAvatar(
                            radius: (screenSize.height * .063) - 2,
                            foregroundImage: NetworkImage(user.data!.image!),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      user.data!.name!,
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenSize.height * .038),

//====================Body Segment====================//
            editProfileDashboardSegment(
              context: context,
              screenSize: screenSize,
            ),
            SizedBox(height: screenSize.height * .022),
            Container(
              margin: EdgeInsets.symmetric(horizontal: screenSize.width * .046),
              width: double.infinity,
              height: 1,
              color: const Color(0xffebebeb),
            ),
            SizedBox(
              height: screenSize.height * .023,
            ),
            profileOptionsSegment(
              context: context,
              screenSize: screenSize,
            ),
            // Expanded(
            //   child: Align(
            //     alignment: Alignment.bottomCenter,
            //     child: Container(
            //       width: screenSize.width * .205,
            //       height: screenSize.height * .043,
            //       decoration: BoxDecoration(
            //         border: Border.all(color: Colors.black),
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //       child: Center(
            //         child: Text(
            //           'Log Out',
            //           style: GoogleFonts.roboto(
            //             fontSize: screenSize.width * .036,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: screenSize.height * .047),
          ],
        ),
      ),
    );
  }
}
