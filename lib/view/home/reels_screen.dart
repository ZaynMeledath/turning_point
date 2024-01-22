import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
import 'package:turning_point/dialog/show_points_received_dialog.dart';
import 'package:turning_point/helper/custom_navigator.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/resources/user_repository.dart';
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
  bool isLoaded = false;
  bool rupeeClicked = false;
  bool rupeeScaled = false;

  @override
  void initState() {
    // log('${UserRepository.decodeJwt()}');
    getReels();
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        isLoaded = true;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    PreloadBloc().disposeAllControllers();
    super.dispose();
  }

  void getReels() async {
    await ReelRepository.getReels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: UserRepository.getUserById(),
        builder: (context, snapshot) {
          final user = UserRepository.getUserFromPreference();
          if (user != null || snapshot.hasData) {
            return Stack(
              alignment: Alignment.center,
              children: [
                //====================Reels Player====================//
                FutureBuilder(
                    future: ReelRepository.getReels(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return const ReelsPageViewer();
                      } else {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(
                            strokeWidth: 5,
                            backgroundColor: Colors.white,
                            valueColor: AlwaysStoppedAnimation(Colors.pink),
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
                                      '${user!.data!.points!}',
                                      style: GoogleFonts.inter(
                                        fontSize: screenSize.width * .04,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            const Color.fromRGBO(27, 27, 27, 1),
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
                  ),
                ),

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
                      foregroundImage: NetworkImage(user.data!.image!),
                    ),
                  ),
                ),

                //====================Rupee Icon====================//
                Positioned(
                  right: screenSize.width * .03,
                  bottom: screenSize.height * .14,
                  child: AnimatedScale(
                    scale: rupeeScaled ? 1.5 : 1,
                    duration: const Duration(milliseconds: 200),
                    child: GestureDetector(
                      onTap: () {
                        if (user.data!.points == 0) {
                          showPointsReceivedDialog(context: context);
                        }

                        setState(() {
                          rupeeClicked = true;
                          rupeeScaled = true;
                        });
                        Future.delayed(const Duration(milliseconds: 200), () {
                          setState(() {
                            rupeeScaled = false;
                          });
                        });
                      },
                      child: Image.asset(
                        'assets/icons/rupee_icon.png',
                        width: screenSize.width * .081,
                        height: screenSize.width * .081,
                        color: rupeeClicked
                            ? const Color.fromRGBO(255, 215, 0, 1)
                            : Colors.white,
                      ),
                    ),
                  ),
                ),

                //====================Download Icon====================//
                Positioned(
                  right: screenSize.width * .03,
                  bottom: screenSize.height * .075,
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.file_download_outlined,
                      size: 35,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 2),
                          color: Colors.grey,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
