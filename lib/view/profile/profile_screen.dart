import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/helper/custom_navigator.dart';
import 'package:turning_point/helper/flight_shuttle.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_loading.dart';
import 'package:turning_point/view/edit_profile/edit_profile_screen.dart';
import 'package:turning_point/view/profile/segments/edit_profile_dashboard_segment.dart';
import 'package:turning_point/view/profile/segments/profile_options_segment.dart';
import 'package:turning_point/view/referral/referral_screen.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

part 'segments/refer_and_earn_container.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (preloadBloc.state.controllers.isNotEmpty) {
      preloadBloc.pauseCurrentController();
    }
    preloadBloc.add(ReelsScreenToggleEvent(isReelsVisible: false));
    profileBloc.add(ProfileLoadEvent(avoidGettingFromPreference: true));
    super.didChangeDependencies();
  }

  void disableWakeLock() {
    setState(() {
      WakelockPlus.disable();
    });
  }

  @override
  void dispose() {
    preloadBloc.add(ReelsScreenToggleEvent(isReelsVisible: true));
    if (preloadBloc.state.controllers.isNotEmpty &&
        !preloadBloc.manuallyPaused) {
      Future.delayed(Duration.zero, () {
        preloadBloc.add(PreloadEvent(
          currentIndex: preloadBloc.state.focusedIndex,
        ));
      });
    }

    super.dispose();
  }

  Future<void> _handleRefresh() async {
    profileBloc.add(ProfileLoadEvent(avoidGettingFromPreference: true));
  }

  @override
  Widget build(BuildContext context) {
    if (preloadBloc.state.controllers.isNotEmpty) {
      preloadBloc.pauseCurrentController();
    }

    preloadBloc.add(ReelsScreenToggleEvent(isReelsVisible: false));
    disableWakeLock();

    return Scaffold(
      body: SafeArea(
        child: LiquidPullToRefresh(
          height: 60,
          animSpeedFactor: 2,
          showChildOpacityTransition: false,
          color: const Color.fromRGBO(89, 165, 255, 1),
          backgroundColor: Colors.white,
          onRefresh: () => _handleRefresh(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                //====================Header segment with Back button, Profile Picture Stack and Name====================//
                SizedBox(height: screenSize.height * .006),
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
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        switch (state) {
                          case ProfileLoadingState():
                            return spinningLinesLoading();
                          case ProfileLoadedState():
                            return Column(
                              children: [
                                SizedBox(height: screenSize.height * .014),
                                Hero(
                                  tag: 'profile_picture',
                                  flightShuttleBuilder: flightShuttleBuilder,
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                      PageTransition(
                                        child: const ProfilePictureView(),
                                        type: PageTransitionType.fade,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: screenSize.height * .063,
                                      backgroundColor: const Color.fromRGBO(
                                          225, 225, 225, .7),
                                      child: CircleAvatar(
                                        radius: (screenSize.height * .063) - 3,
                                        child: CircleAvatar(
                                          radius:
                                              (screenSize.height * .063) - 4,
                                          foregroundImage: NetworkImage(
                                              state.userModel!.image!),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  state.userModel!.name!,
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            );

                          default:
                            return spinningLinesLoading();
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
                  margin:
                      EdgeInsets.symmetric(horizontal: screenSize.width * .046),
                  width: double.infinity,
                  height: 1,
                  color: const Color(0xffebebeb),
                ),
                SizedBox(height: screenSize.height * .023),
                profileOptionsSegment(context: context),
                // SizedBox(height: screenSize.height * .012),
                // referAndEarnContainer(context: context),
                SizedBox(height: screenSize.height * .03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
