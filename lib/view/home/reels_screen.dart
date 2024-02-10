import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/helper/custom_navigator.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/preferences/app_preferences.dart';
import 'package:turning_point/resources/reel_repository.dart';
import 'package:turning_point/view/home/reels_page_viewer.dart';
import 'package:turning_point/view/points/points_screen.dart';
import 'package:turning_point/view/profile/profile_screen.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  @override
  void initState() {
    log(AppPreferences.getValueShared('auth_token'));
    super.initState();
  }

  @override
  void dispose() {
    PreloadBloc().disposeAllControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(ProfileLoadEvent());
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          switch (state) {
            case ProfileLoadingState():
              return const Center(
                child: CircularProgressIndicator.adaptive(
                  strokeWidth: 5,
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),
              );
            case ProfileLoadErrorState():
              return Expanded(
                child: Container(
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      'Something Went Wrong',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .05,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            case ProfileLoadedState():
              return Stack(
                alignment: Alignment.center,
                children: [
                  //====================Reels Player====================//
                  FutureBuilder(
                      future: ReelRepository.getReels(),
                      builder: (context, reelsSnapshot) {
                        if (reelsSnapshot.hasData) {
                          return ReelsPageViewer(
                            user: state.userModel,
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(
                              strokeWidth: 5,
                              backgroundColor: Colors.white,
                              valueColor: AlwaysStoppedAnimation(Colors.amber),
                            ),
                          );
                        }
                      }),

                  //====================Points Container====================//
                  Positioned(
                      top: screenSize.height * .071,
                      left: screenSize.width * .031,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  CustomNavigator.push(
                                    context: context,
                                    child: const PointsScreen(),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: screenSize.width * .026,
                                    right: screenSize.width * .04,
                                    top: screenSize.width * .013,
                                    bottom: screenSize.width * .013,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromRGBO(255, 215, 0, 1),
                                        Color.fromRGBO(255, 238, 141, 1),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/icons/coin_icon.png',
                                          width: screenSize.width * .06,
                                        ),
                                        const SizedBox(width: 1),
                                        Text(
                                          '${state.userModel.points!}',
                                          style: GoogleFonts.inter(
                                            fontSize: screenSize.width * .04,
                                            fontWeight: FontWeight.w700,
                                            color: const Color.fromRGBO(
                                                27, 27, 27, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),

                  //====================Avatar Icon====================//
                  Positioned(
                    right: screenSize.width * .03,
                    top: screenSize.height * .07,
                    child: GestureDetector(
                      onTap: () => CustomNavigator.push(
                        context: context,
                        child: const ProfileScreen(),
                      ),
                      child: CircleAvatar(
                        backgroundColor:
                            const Color.fromRGBO(225, 225, 225, .6),
                        radius: 22,
                        child: CircleAvatar(
                          foregroundImage: NetworkImage(state.userModel.image!),
                        ),
                      ),
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
