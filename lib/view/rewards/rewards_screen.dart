import 'package:flutter/material.dart';
import 'package:turning_point/controller/rewards_provider.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/rewards/segments/rank_list_segment.dart';
import 'package:turning_point/view/rewards/segments/rewards_body_segment.dart';
import 'package:turning_point/view/rewards/segments/rewards_tab_bar.dart';

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
    tabController = TabController(length: 2, vsync: this);
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >= screenSize.height * .325) {
        setState(() {
          isScrolled = true;
        });
      } else {
        setState(() {
          isScrolled = false;
        });
      }
    });
    super.initState();
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
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
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
            flexibleSpace: rewardsBodySegment(screenSize: screenSize),
          ),
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            automaticallyImplyLeading: false,
            toolbarHeight: 10,
            flexibleSpace: rewardsTabBar(
              screenSize: screenSize,
              tabController: tabController,
            ),
          ),

//====================Rank List====================//
          SliverList(
            delegate: SliverChildBuilderDelegate(childCount: rankList.length,
                (context, index) {
              return rankListSegment(screenSize: screenSize, index: index);
            }),
          )
        ],
      ),
    );
  }
}
