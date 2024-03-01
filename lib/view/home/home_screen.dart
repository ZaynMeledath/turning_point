// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/bloc/home/home_bloc.dart';
import 'package:turning_point/bloc/points/points_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/dialog/show_connect_dialog.dart';
import 'package:turning_point/view/home/reels_screen.dart';
import 'package:turning_point/view/lucky_draw/lucky_draw_screen.dart';
import 'package:turning_point/view/rewards/rewards_screen.dart';
import 'package:turning_point/view/scanner/scanner_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pages = [
    const ReelsScreen(),
    const RewardsScreen(),
    const ScannerScreen(),
    const LuckyDrawScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    pointsBloc.add(PointsLoadEvent());
    profileBloc.add(ProfileLoadEvent());
    super.didChangeDependencies();
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) async {
        if (state is ConnectState) {
          final isClosed = await showConnectDialog(context: context) as bool;
          if (isClosed) {
            homeBloc.add(TriggerEvent(state.currentIndex));
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: pages[state.currentIndex],
          //===============Bottom Navigation Bar===============//
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: state.currentIndex,
            onTap: (index) async {
              homeBloc.add(TriggerEvent(index));
            },
            backgroundColor: state.currentIndex == 0 || state.currentIndex == 2
                ? const Color(0xff0c1313)
                : Colors.white,
            unselectedItemColor:
                state.currentIndex == 0 || state.currentIndex == 2
                    ? Colors.white
                    : Colors.black,
            enableFeedback: true,
            selectedItemColor:
                state.currentIndex == 0 || state.currentIndex == 2
                    ? Colors.white
                    : Colors.black,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Colors.black,
                label: 'Home',
                icon: Image.asset(
                  state.currentIndex == 0 && state is! ConnectState
                      ? 'assets/icons/home_icon_purple.png'
                      : state.currentIndex == 2 || state.currentIndex == 0
                          ? 'assets/icons/home_icon_dark.png'
                          : 'assets/icons/home_icon_light.png',
                  width: 23,
                  height: 23,
                ),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                label: 'Rewards',
                icon: Image.asset(
                  state.currentIndex == 1 && state is! ConnectState
                      ? 'assets/icons/rewards_icon_purple.png'
                      : state.currentIndex == 0 || state.currentIndex == 2
                          ? 'assets/icons/rewards_icon_dark.png'
                          : 'assets/icons/rewards_icon_light.png',
                  width: 23,
                  height: 23,
                ),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.black,
                label: 'Scan',
                icon: Image.asset(
                  state.currentIndex == 2 && state is! ConnectState
                      ? 'assets/icons/scanner_icon_purple.png'
                      : state.currentIndex == 0 || state.currentIndex == 2
                          ? 'assets/icons/scanner_icon_dark.png'
                          : 'assets/icons/scanner_icon_light.png',
                  width: 35,
                  height: 35,
                ),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                label: 'Lucky Draw',
                icon: Image.asset(
                  state.currentIndex == 3 && state is! ConnectState
                      ? 'assets/icons/lucky_draw_icon_purple.png'
                      : state.currentIndex == 0 || state.currentIndex == 2
                          ? 'assets/icons/lucky_draw_icon_dark.png'
                          : 'assets/icons/lucky_draw_icon_light.png',
                  width: 23,
                  height: 23,
                ),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                label: 'Connect',
                icon: Image.asset(
                  state is ConnectState
                      ? 'assets/icons/connect_icon_purple.png'
                      : state.currentIndex == 0 || state.currentIndex == 2
                          ? 'assets/icons/connect_icon_dark.png'
                          : 'assets/icons/connect_icon_light.png',
                  width: 23,
                  height: 23,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
