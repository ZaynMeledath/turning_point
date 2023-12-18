import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/view/profile/segments/edit_profile_dashboard_segment.dart';
import 'package:turning_point/view/profile/segments/profile_options_segment.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
//====================Header segment with Back button, Profile Picture Stack and Name====================//
            SizedBox(height: screenSize.height * .009),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * .03),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Hero(
                      tag: 'back_button',
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: screenSize.width * .054,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: screenSize.height * .012),
                        Hero(
                          tag: 'profile_picture',
                          child: CircleAvatar(
                            radius: screenSize.height * .063,
                            backgroundColor: const Color(0xffe12826),
                            child: CircleAvatar(
                              radius: (screenSize.height * .063) - 1,
                              child: CircleAvatar(
                                radius: (screenSize.height * .063) - 2,
                                foregroundImage: const AssetImage(
                                    'assets/images/avatar.jpg'),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Furnipart',
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: screenSize.width * .205,
                  height: screenSize.height * .043,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Log Out',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .036,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenSize.height * .047),
          ],
        ),
      ),
    );
  }
}
