import 'package:flutter/material.dart';
import 'package:turning_point/controller/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

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
            label: 'Scan',
            icon: Image.asset(
              currentIndex == 0
                  ? 'assets/icons/scanner_icon_dark.png'
                  : 'assets/icons/scanner_icon_light.png',
              width: 35,
              height: 35,
              // color: currentIndex == 0
              //     ? Colors.white
              //     : Colors.black.withOpacity(.8),
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
            label: 'Connect',
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
