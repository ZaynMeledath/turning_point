import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point/bloc/lucky_draw/lucky_draw_bloc.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
import 'package:turning_point/bloc/rewards/rewards_bloc.dart';
import 'package:turning_point/utils/screen_size.dart';
import 'package:turning_point/utils/widget/custom_loading.dart';
import 'package:turning_point/model/rewards_model.dart';
import 'package:turning_point/view/rewards/segments/rank_list_segment.dart';
import 'package:turning_point/view/rewards/segments/rewards_body_segment.dart';
import 'package:turning_point/view/rewards/segments/rewards_tab_bar.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

part 'single_contest_rewards_screen.dart';
part 'segments/single_contest_rewards_tab_bar.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  late final ScrollController scrollController;
  bool audioPlayed = false;
  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >= screenSize.height * .325) {
        rewardsBloc.add(RewardsScreenScrolledEvent(isScrolled: true));
      } else {
        rewardsBloc.add(RewardsScreenScrolledEvent(isScrolled: false));
      }
    });
    tabController.addListener(() {
      rewardsBloc.add(
        RewardsTabSwitchedEvent(tabController.index),
      );
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (preloadBloc.state.controllers.isNotEmpty) {
      preloadBloc.pauseCurrentController();
    }
    preloadBloc.add(ReelsScreenToggleEvent(isReelsVisible: false));
    luckyDrawBloc.add(LuckyDrawLoadEvent());

    Future.delayed(const Duration(milliseconds: 100), () {
      rewardsBloc.add(RewardsLoadEvent());
    });
    disableWakeLock();
    super.didChangeDependencies();
  }

  void disableWakeLock() async {
    setState(() {
      WakelockPlus.disable();
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (preloadBloc.state.controllers.isNotEmpty) {
      preloadBloc.pauseCurrentController();
    }
    preloadBloc.add(ReelsScreenToggleEvent(isReelsVisible: false));
    return Scaffold(
      body: BlocBuilder<RewardsBloc, RewardsState>(
        builder: (context, rewardsState) {
          switch (rewardsState) {
            case RewardsLoadingState():
              return spinningLinesLoading(color: Colors.red);

            case RewardsLoadedState():
              if (rewardsState.currentRewardsModel != null &&
                  rewardsState.previousRewardsModel != null) {
                if (luckyDrawBloc.isWinnerDisplayEventActive) {
                  if (!audioPlayed) {
                    audioPlayed = true;
                    audioPlayer.play(
                      mode: PlayerMode.lowLatency,
                      AssetSource('sounds/ding_sparkle_sound.mp3'),
                    );
                  }
                  return SingleContestRewardsScreen(
                    rewardsModel: rewardsState.previousRewardsModel,
                  );
                }
                if (!audioPlayed) {
                  audioPlayed = true;
                  AudioPlayer().play(
                    mode: PlayerMode.lowLatency,
                    AssetSource('sounds/ding_sparkle_sound.mp3'),
                  );
                }
                final activeRewardsModel = rewardsState.tabIndex == 0
                    ? rewardsState.currentRewardsModel!
                    : rewardsState.previousRewardsModel!;
                return NestedScrollView(
                  controller: scrollController,

                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      //====================Header Segment====================//
                      SliverAppBar(
                        backgroundColor: Colors.white,
                        expandedHeight: screenSize.height * .58,
                        pinned: true,
                        leading: SafeArea(
                          child: Column(
                            children: [
                              SizedBox(height: screenSize.height * .012),
                              Image.asset(
                                'assets/images/rewards_logo.png',
                                width: screenSize.width * .36,
                              ),
                            ],
                          ),
                        ),
                        leadingWidth: double.infinity,
                        toolbarHeight: screenSize.height * .069,
                        automaticallyImplyLeading: false,
                        flexibleSpace: rewardsBodySegment(),
                      ),

                      SliverAppBar(
                        backgroundColor: Colors.white,
                        pinned: true,
                        automaticallyImplyLeading: false,
                        toolbarHeight: screenSize.width >= 550
                            ? screenSize.width * .07
                            : screenSize.width * .05,
                        flexibleSpace: rewardsTabBar(
                          tabController: tabController,
                        ),
                      ),
                    ];
                  },
                  //====================Rank List====================//
                  body: activeRewardsModel.contestPrizes!.length > 3
                      ? TabBarView(
                          controller: tabController,
                          children: [
                            ListView.builder(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenSize.height * .01),
                              itemCount: rewardsState.currentRewardsModel!
                                      .contestPrizes!.length -
                                  3,
                              itemBuilder: (context, index) {
                                return rankListSegment(
                                  index: index,
                                  rewardsModel:
                                      rewardsState.currentRewardsModel!,
                                );
                              },
                            ),
                            ListView.builder(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenSize.height * .01),
                              itemCount: rewardsState.previousRewardsModel!
                                      .contestPrizes!.length -
                                  3,
                              itemBuilder: (context, index) {
                                return rankListSegment(
                                  index: index,
                                  rewardsModel:
                                      rewardsState.previousRewardsModel!,
                                );
                              },
                            ),
                          ],
                        )
                      : Container(),
                );
              } else if (rewardsState.currentRewardsModel != null &&
                  rewardsState.previousRewardsModel == null &&
                  !luckyDrawBloc.isWinnerDisplayEventActive) {
                if (!audioPlayed) {
                  audioPlayed = true;
                  audioPlayer.play(
                    mode: PlayerMode.lowLatency,
                    AssetSource('sounds/ding_sparkle_sound.mp3'),
                  );
                }
                return const SingleContestRewardsScreen();
              } else {
                return SafeArea(
                  child: LiquidPullToRefresh(
                    onRefresh: () async {
                      if (luckyDrawBloc.state.secondsLeft == null ||
                          luckyDrawBloc.state.secondsLeft! == 0) {
                        rewardsBloc.add(RewardsLoadEvent());
                      }
                    },
                    height: 80,
                    animSpeedFactor: 2,
                    showChildOpacityTransition: false,
                    color: const Color.fromRGBO(89, 165, 255, 1),
                    backgroundColor: Colors.white,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: screenSize.height * .26),
                            Lottie.asset(
                              'assets/lottie/no_data_animation.json',
                              width: screenSize.width * .5,
                            ),
                            Text(
                              'No Data Available at the moment',
                              style: GoogleFonts.inter(
                                fontSize: screenSize.width * .04,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(.75),
                                height: .1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}





// SliverList(
//             delegate: SliverChildBuilderDelegate(childCount: rankList.length,
//                 (context, index) {
//               return rankListSegment(screenSize: screenSize, index: index);
//             }),
//           ),
