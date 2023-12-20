import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/home/reels_page_viewer.dart';
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
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        isLoaded = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
//====================Reels Player====================//
          const ReelsPageViewer(),

//====================Avatar Icon====================//
          Positioned(
            right: screenSize.width * .03,
            top: 60,
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                PageTransition(
                  duration: const Duration(milliseconds: 350),
                  reverseDuration: const Duration(milliseconds: 350),
                  child: const ProfileScreen(),
                  type: PageTransitionType.rightToLeft,
                ),
              ),
              child: const CircleAvatar(
                foregroundImage: AssetImage('assets/images/avatar.jpg'),
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
                ),
              ),
            ),
          ),

//====================Download Icon====================//
          Positioned(
            right: screenSize.width * .03,
            bottom: screenSize.height * .082,
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
      ),
    );
  }
}
