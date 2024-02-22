import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/helper/flight_shuttle.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/profile/segments/edit_profile_dashboard_segment.dart';
import 'package:turning_point/view/profile/segments/profile_options_segment.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    switch (state) {
                      case ProfileLoadingState():
                        return const Center(
                          child: CircularProgressIndicator.adaptive(
                            strokeWidth: 5,
                            backgroundColor: Colors.white,
                            valueColor: AlwaysStoppedAnimation(Colors.amber),
                          ),
                        );
                      case ProfileLoadedState():
                        return Column(
                          children: [
                            SizedBox(height: screenSize.height * .014),
                            Hero(
                              tag: 'profile_picture',
                              flightShuttleBuilder: flightShuttleBuilder,
                              child: CircleAvatar(
                                radius: screenSize.height * .063,
                                backgroundColor:
                                    const Color.fromRGBO(225, 225, 225, .7),
                                child: CircleAvatar(
                                  radius: (screenSize.height * .063) - 3,
                                  child: CircleAvatar(
                                    radius: (screenSize.height * .063) - 4,
                                    foregroundImage:
                                        NetworkImage(state.userModel.image!),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              state.userModel.name!,
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );

                      default:
                        return const Center(
                          child: CircularProgressIndicator.adaptive(
                            strokeWidth: 5,
                            backgroundColor: Colors.white,
                            valueColor: AlwaysStoppedAnimation(Colors.red),
                          ),
                        );
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: screenSize.height * .038),

//====================Body Segment====================//
            editProfileDashboardSegment(
              context: context,
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
            ),

            SizedBox(height: screenSize.height * .047),
          ],
        ),
      ),
    );
  }
}
