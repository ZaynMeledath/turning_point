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
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
//====================Reels Player====================//
          const PageViewer(),

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

//===============Bottom Navigation Bar===============//
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        backgroundColor: currentIndex == 0 ? Colors.black : Colors.white,
        unselectedItemColor: currentIndex == 0 ? Colors.white : Colors.black,
        enableFeedback: true,
        selectedItemColor: currentIndex == 0 ? Colors.yellow : Colors.blue,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            label: 'Home',
            icon: Image.asset(
              'assets/icons/home_icon.png',
              width: 23,
              height: 23,
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            label: 'Rewards',
            icon: Image.asset(
              'assets/icons/rewards_icon.png',
              width: 23,
              height: 23,
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            label: currentIndex == 2 ? 'Scanner' : '',
            icon: Image.asset(
              'assets/icons/scanner_icon.png',
              width: 35,
              height: 35,
              color: currentIndex == 0
                  ? Colors.white
                  : Colors.black.withOpacity(.8),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            label: 'Lucky Draw',
            icon: Image.asset(
              'assets/icons/gift_box_icon.png',
              width: 23,
              height: 23,
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            label: 'Rewards',
            icon: Image.asset(
              'assets/icons/connect_icon.png',
              width: 23,
              height: 23,
            ),
          ),
        ],
      ),
    );
  }
}
