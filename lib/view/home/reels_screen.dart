// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:turning_point/bloc/points/points_bloc.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/utils/custom_navigator.dart';
import 'package:turning_point/utils/screen_size.dart';
import 'package:turning_point/utils/widget/custom_loading.dart';
import 'package:turning_point/preferences/app_preferences.dart';
import 'package:turning_point/resources/reels_repository.dart';
import 'package:turning_point/view/home/profile_inactive_screen.dart';
import 'package:turning_point/view/home/reels_page_viewer.dart';
import 'package:turning_point/view/points/points_screen.dart';
import 'package:turning_point/view/profile/profile_screen.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => ReelsScreenState();
}

class ReelsScreenState extends State<ReelsScreen>
    with SingleTickerProviderStateMixin {
  static late AnimationController likeAnimationController;
  static late Animation<double> likeAnimation;

  @override
  void initState() {
    log('${AppPreferences.getValueShared('auth_token')}');

    likeAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    likeAnimation = Tween<double>(
      begin: 1,
      end: 1.4,
    ).animate(likeAnimationController);

    likeAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        likeAnimationController.reverse();
      }
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      WakelockPlus.enable();
    });
    // locationServiceBloc.add(LocationServiceStartEvent());
    preloadBloc.add(ReelsScreenToggleEvent(isReelsVisible: true));

    if (!preloadBloc.manuallyPaused) {
      Future.delayed(Duration.zero, () {
        preloadBloc.add(
          PreloadEvent(
            currentIndex: preloadBloc.state.focusedIndex,
          ),
        );
      });
    }
    getFcmToken();
    super.didChangeDependencies();
  }

  void getFcmToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    log('FCM Token : ${token.toString()}');
  }

  @override
  void dispose() {
    super.dispose();
    preloadBloc.add(ReelsScreenToggleEvent(isReelsVisible: false));
    if (preloadBloc.state.controllers.isNotEmpty) {
      preloadBloc.pauseCurrentController();
    }
  }

  Future<void> handleRefresh() async {
    ReelsRepository.urlList.clear();
    preloadBloc.manuallyPaused = false;
    await ReelsRepository.getReels(page: 1);
    preloadBloc.add(PreloadEvent(
      currentIndex: 0,
      isInitial: true,
      isReloading: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          switch (state) {
            case ProfileLoadingState():
              return spinningLinesLoading();

            case ProfileInactiveState():
              return ProfileInactiveScreen();

            case ProfileLoadErrorState():
              return Scaffold(
                body: Expanded(
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
                ),
              );
            case ProfileLoadedState():
              return LiquidPullToRefresh(
                onRefresh: () => handleRefresh(),
                animSpeedFactor: 1.7,
                height: 70,
                showChildOpacityTransition: false,
                color: Colors.teal,
                backgroundColor: Colors.white,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    //====================Reels Player====================//

                    const ReelsPageViewer(),

                    //====================Points Container====================//
                    Positioned(
                      top: screenSize.height * .071,
                      left: screenSize.width * .035,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ScaleTransition(
                                scale: likeAnimation,
                                child: GestureDetector(
                                  onTap: () async {
                                    preloadBloc.pauseCurrentController();
                                    CustomNavigator.push(
                                      context: context,
                                      child: const PointsScreen(
                                        directEntry: true,
                                      ),
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
                                          BlocBuilder<PointsBloc, PointsState>(
                                            builder: (context, pointsState) {
                                              return Text(
                                                pointsState.points == null
                                                    ? 'Loading...'
                                                    : pointsState.points
                                                        .toString(),
                                                style: GoogleFonts.inter(
                                                  fontSize: pointsState
                                                              .points ==
                                                          null
                                                      ? screenSize.width * .031
                                                      : screenSize.width * .04,
                                                  fontWeight:
                                                      pointsState.points == null
                                                          ? FontWeight.w500
                                                          : FontWeight.w700,
                                                  color: const Color.fromRGBO(
                                                      27, 27, 27, 1),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    //====================Avatar Icon====================//
                    Positioned(
                      right: screenSize.width * .03,
                      top: screenSize.height * .065,
                      child: GestureDetector(
                        onTap: () async {
                          preloadBloc.pauseCurrentController();
                          CustomNavigator.push(
                            context: context,
                            child: const ProfileScreen(),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor:
                              const Color.fromRGBO(225, 225, 225, .6),
                          radius: screenSize.width * .056,
                          child: CircleAvatar(
                            radius: screenSize.width * .05,
                            foregroundImage: CachedNetworkImageProvider(
                              state.userModel!.image!,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
