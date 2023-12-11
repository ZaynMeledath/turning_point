import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turning_point/controller/home_provider.dart';
import 'package:turning_point/view/home/page_viewer.dart';
import 'package:turning_point/view/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoaded = false;
  bool dollarClicked = false;
  bool dollarScaled = false;

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
    // final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          const PageViewer(),
          Positioned(
              right: 10,
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
              )),
          Positioned(
            right: 10,
            bottom: 140,
            child: AnimatedScale(
              scale: dollarScaled ? 1.5 : 1,
              duration: const Duration(milliseconds: 200),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    dollarClicked = true;
                    dollarScaled = true;
                  });
                  Future.delayed(const Duration(milliseconds: 200), () {
                    setState(() {
                      dollarScaled = false;
                    });
                  });
                },
                child: Icon(
                  CupertinoIcons.money_dollar_circle,
                  size: 35,
                  color: dollarClicked ? Colors.red : Colors.white,
                  shadows: const [
                    Shadow(
                      offset: Offset(0, 2),
                      color: Colors.grey,
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 75,
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

//===============Bottom Navigation Bar===============//
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        height: 68,
        color: currentIndex == 0 ? Colors.black : Colors.white,
        animationDuration: const Duration(milliseconds: 350),
        backgroundColor: Colors.grey.shade500,
        buttonBackgroundColor: currentIndex == 0 ? Colors.white : Colors.black,
        items: [
          Image.asset(
            'assets/icons/rewards_icon.png',
            width: 23,
            height: 23,
            color: Colors.black,
          ),
          Image.asset(
            'assets/icons/scanner_icon.png',
            width: 22,
            height: 22,
            color: currentIndex == 0 || currentIndex == 1
                ? Colors.white
                : Colors.black.withOpacity(.7),
          ),
          Image.asset(
            'assets/icons/gift_box_icon.png',
            width: 22,
            height: 22,
          ),
          Image.asset(
            'assets/icons/connect_icon.png',
            width: 22,
            height: 22,
            color: currentIndex == 0 || currentIndex == 3
                ? Colors.white
                : Colors.black.withOpacity(.7),
          )
        ],
      ),
    );
  }
}
