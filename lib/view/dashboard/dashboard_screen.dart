import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/contest/contest_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_app_bar.dart';
import 'package:turning_point/view/dashboard/segments/dashboard_available_balance_container.dart';
import 'package:turning_point/view/dashboard/segments/dashboard_activity_container.dart';
import 'package:turning_point/view/dashboard/segments/dashboard_coupon_segment.dart';
import 'package:turning_point/view/home/profile_inactive_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  bool startAnimation = false;
  bool isWhite = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1), () {
      setState(() {
        startAnimation = true;
      });
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      setState(() {
        isWhite = true;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    contestBloc.add(ContestTimerDisposeEvent());
  }

  @override
  Widget build(BuildContext context) {
    profileBloc.add(ProfileLoadEvent());
    contestBloc.add(ContestLoadEvent());
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(
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

            case ProfileInactiveState():
              return ProfileInactiveScreen();

            case ProfileLoadErrorState():
              return Center(
                child: Text(
                  'Something Went Wrong',
                  style: GoogleFonts.poppins(
                    fontSize: screenSize.width * .05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );

            case ProfileLoadedState():
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: realScreenSize.width * 1.03,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          top: -realScreenSize.width * .92,
                          child: AnimatedContainer(
                            width: realScreenSize.width * 1.8,
                            height:
                                startAnimation ? realScreenSize.width * 1.8 : 0,
                            duration: const Duration(milliseconds: 1000),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(141, 193, 255, 1),
                                  Color.fromRGBO(89, 165, 255, 1),
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                            ),
                          ),
                        ),
                        SafeArea(
                          child: customAppBar(
                            context: context,
                            title: 'Dashboard',
                            foregroundColor: isWhite ? Colors.white : null,
                          ),
                        ),
                        Positioned(
                          top: screenSize.width * .28,
                          child: Column(
                            children: [
                              Hero(
                                tag: 'profile_picture',
                                child: CircleAvatar(
                                  radius: screenSize.height * .056,
                                  backgroundColor:
                                      const Color.fromRGBO(225, 225, 225, .3),
                                  child: CircleAvatar(
                                    radius: (screenSize.height * .056) - 4,
                                    backgroundColor:
                                        const Color.fromRGBO(225, 225, 225, .6),
                                    child: CircleAvatar(
                                      radius: (screenSize.height * .056) - 8,
                                      foregroundImage:
                                          NetworkImage(state.userModel!.image!),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                state.userModel!.name!,
                                style: GoogleFonts.roboto(
                                  fontSize: screenSize.width * .041,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '+91********${state.userModel!.phone!.substring(8)}',
                                style: GoogleFonts.roboto(
                                  fontSize: screenSize.width * .026,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        dashboardAvailableBalanceContainer(
                          context: context,
                          userModel: state.userModel!,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * .09),
                    child: Text(
                      'Activity',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .041,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * .01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      dashboardActivityContainer(
                        title: 'Contests Won',
                        imagePath: 'assets/images/dashboard_contest_image.png',
                        userModel: state.userModel!,
                        imageHeight: screenSize.height * .054,
                        imageContainerGradient: [
                          const Color.fromRGBO(255, 227, 205, 1),
                          const Color.fromRGBO(255, 245, 203, 1),
                        ],
                        isContestContainer: true,
                      ),
                      dashboardActivityContainer(
                          title: 'Badges Earned',
                          imagePath:
                              'assets/images/dashboard_challenges_image.png',
                          userModel: state.userModel!,
                          imageHeight: screenSize.height * .058,
                          imageContainerGradient: [
                            const Color.fromRGBO(187, 221, 255, 1),
                            const Color.fromRGBO(234, 244, 255, 1),
                          ]),
                    ],
                  ),
                  SizedBox(height: screenSize.height * .025),
                  Container(
                    height: 1,
                    margin: EdgeInsets.symmetric(
                        horizontal: screenSize.width * .051),
                    width: double.infinity,
                    color: const Color.fromRGBO(205, 205, 204, 1),
                  ),
                  SizedBox(height: screenSize.height * .015),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * .09),
                    child: Text(
                      'Coupons',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .041,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  dashboardCouponSegment(context: context)
                ],
              );
          }
        },
      ),
    );
  }
}
