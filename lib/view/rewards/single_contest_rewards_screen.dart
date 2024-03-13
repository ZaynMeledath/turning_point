part of 'rewards_screen.dart';

class SingleContestRewardsScreen extends StatefulWidget {
  const SingleContestRewardsScreen({super.key});

  @override
  State<SingleContestRewardsScreen> createState() =>
      _SingleContestRewardsScreenState();
}

class _SingleContestRewardsScreenState extends State<SingleContestRewardsScreen>
    with SingleTickerProviderStateMixin {
  late final ScrollController scrollController;
  late final TabController tabController;

  @override
  void initState() {
    scrollController = ScrollController();
    tabController = TabController(
      length: 1,
      vsync: this,
    );
    scrollController.addListener(() {
      if (scrollController.offset >= screenSize.height * .325) {
        rewardsBloc.add(RewardsScreenScrolledEvent(isScrolled: true));
      } else {
        rewardsBloc.add(RewardsScreenScrolledEvent(isScrolled: false));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RewardsBloc, RewardsState>(
      builder: (context, state) {
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
                toolbarHeight: screenSize.width * .07,
                flexibleSpace: singleContestRewardsTabBar(tabController),
              ),
            ];
          },
          //====================Rank List====================//
          body: state.currentRewardsModel!.contestPrizes!.length > 3
              ? ListView.builder(
                  padding:
                      EdgeInsets.symmetric(vertical: screenSize.height * .01),
                  itemCount: rankList.length,
                  itemBuilder: (context, index) {
                    return rankListSegment(
                      index: index,
                      rewardsModel: state.currentRewardsModel!,
                    );
                  },
                )
              : Container(),
        );
      },
    );
  }
}
