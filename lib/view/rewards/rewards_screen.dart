import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
import 'package:turning_point/bloc/rewards/rewards_bloc.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_loading.dart';
import 'package:turning_point/view/rewards/segments/rank_list_segment.dart';
import 'package:turning_point/view/rewards/segments/rewards_body_segment.dart';
import 'package:turning_point/view/rewards/segments/rewards_tab_bar.dart';

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

  @override
  void initState() {
    if (preloadBloc.state.controllers.isNotEmpty) {
      preloadBloc.pauseCurrentController();
    }
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
    rewardsBloc.add(RewardsLoadEvent());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RewardsBloc, RewardsState>(
        builder: (context, rewardsState) {
          switch (rewardsState) {
            case RewardsLoadingState():
              return spinningLinesLoading(color: Colors.red);

            case RewardsLoadedState():
              if (rewardsState.currentRewardsModel != null &&
                  rewardsState.previousRewardsModel != null) {
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
                        toolbarHeight: 0,
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
                              itemCount:
                                  activeRewardsModel.contestPrizes!.length - 3,
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
                              itemCount:
                                  activeRewardsModel.contestPrizes!.length - 3,
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
                  rewardsState.previousRewardsModel == null) {
                return const SingleContestRewardsScreen();
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(height: screenSize.height * .25),
                      Lottie.asset(
                        'assets/lottie/no_data_animation.json',
                        width: screenSize.width * .5,
                      ),
                      // Text('No ')
                    ],
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
