// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/bloc/home/home_bloc.dart';
import 'package:turning_point/bloc/location_service/location_service_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/dialog/show_connect_dialog.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_loading.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/view/home/reels_screen.dart';
import 'package:turning_point/view/lucky_draw/lucky_draw_screen.dart';
import 'package:turning_point/view/rewards/rewards_screen.dart';
import 'package:turning_point/view/scanner/scanner_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  // void updateUserOnlineStatus({required bool isOnline}) async {
  //   await UserRepository.updateUserOnlineStatus(isOnline: isOnline);
  // }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    locationServiceBloc.add(LocationServiceStartEvent());
    if (state == AppLifecycleState.resumed) {
      UserRepository.updateUserOnlineStatus(isOnline: true);
    } else {
      UserRepository.updateUserOnlineStatus(isOnline: false);
    }
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
          await showConnectDialog(
            context: context,
            isDark: homeBloc.state.currentIndex == 0 ? true : false,
          ) as bool?;
          homeBloc.add(TriggerEvent(state.currentIndex));
        }
      },
      builder: (context, homeState) {
        return BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, profileState) {
            if (profileState is ProfileLoadedState) {
              final pages = [
                const ReelsScreen(),
                const RewardsScreen(),
                if (!profileState.isContractor) const ScannerScreen(),
                const LuckyDrawScreen(),
              ];
              return Scaffold(
                body: pages[homeState.currentIndex],
                //===============Bottom Navigation Bar===============//
                bottomNavigationBar: SizedBox(
                  height: screenSize.height * .075,
                  child: BottomNavigationBar(
                    selectedFontSize: screenSize.width * .031,
                    unselectedFontSize: screenSize.width * .029,
                    elevation: 5,
                    type: BottomNavigationBarType.fixed,
                    currentIndex: homeState.currentIndex,
                    onTap: (index) async {
                      homeBloc.add(TriggerEvent(index));
                    },
                    backgroundColor: homeState.currentIndex == 0
                        // || state.currentIndex == 2
                        ? const Color(0xff0c1313)
                        : Colors.white,
                    unselectedItemColor: homeState.currentIndex == 0
                        // || state.currentIndex == 2
                        ? Colors.white
                        : Colors.black,
                    enableFeedback: true,
                    selectedItemColor: homeState.currentIndex == 0
                        // || state.currentIndex == 2
                        ? Colors.white
                        : Colors.black,
                    showUnselectedLabels: true,
                    items: [
                      BottomNavigationBarItem(
                        backgroundColor: Colors.black,
                        label: 'Home',
                        icon: Image.asset(
                          homeState.currentIndex == 0 &&
                                  homeState is! ConnectState
                              ? 'assets/icons/home_icon_purple.png'
                              : homeState.currentIndex == 0
                                  // || state.currentIndex == 2
                                  ? 'assets/icons/home_icon_dark.png'
                                  : 'assets/icons/home_icon_light.png',
                          width: screenSize.height * .025,
                        ),
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.white,
                        label: 'Rewards',
                        icon: Image.asset(
                          homeState.currentIndex == 1 &&
                                  homeState is! ConnectState
                              ? 'assets/icons/rewards_icon_purple.png'
                              : homeState.currentIndex == 0
                                  // || state.currentIndex == 2
                                  ? 'assets/icons/rewards_icon_dark.png'
                                  : 'assets/icons/rewards_icon_light.png',
                          width: screenSize.height * .025,
                        ),
                      ),
                      if (!profileState.isContractor)
                        BottomNavigationBarItem(
                          backgroundColor: Colors.black,
                          label: 'Scan',
                          icon: Image.asset(
                            homeState.currentIndex == 2 &&
                                    homeState is! ConnectState
                                ? 'assets/icons/scanner_icon_purple.png'
                                : homeState.currentIndex == 0
                                    // || state.currentIndex == 2
                                    ? 'assets/icons/scanner_icon_dark.png'
                                    : 'assets/icons/scanner_icon_light.png',
                            width: screenSize.height * .035,
                          ),
                        ),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.white,
                        label: 'Lucky Draw',
                        icon: Image.asset(
                          homeState.currentIndex == 3 &&
                                  homeState is! ConnectState
                              ? 'assets/icons/lucky_draw_icon_purple.png'
                              : homeState.currentIndex == 0
                                  // || state.currentIndex == 2
                                  ? 'assets/icons/lucky_draw_icon_dark.png'
                                  : 'assets/icons/lucky_draw_icon_light.png',
                          width: screenSize.height * .025,
                        ),
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.white,
                        label: 'Connect',
                        icon: Image.asset(
                          homeState is ConnectState
                              ? 'assets/icons/connect_icon_purple.png'
                              : homeState.currentIndex == 0
                                  // || state.currentIndex == 2
                                  ? 'assets/icons/connect_icon_dark.png'
                                  : 'assets/icons/connect_icon_light.png',
                          width: screenSize.height * .025,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return rippleLoading();
            }
          },
        );
      },
    );
  }
}
