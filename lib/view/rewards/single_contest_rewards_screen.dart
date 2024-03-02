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
  Widget build(BuildContext context) {
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
            flexibleSpace: singleContestRewardsTabBar(tabController),
          ),
        ];
      },
      //====================Rank List====================//
      body: BlocBuilder<RewardsBloc, RewardsState>(
        builder: (context, state) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: screenSize.height * .01),
            itemCount: rankList.length,
            itemBuilder: (context, index) {
              return rankListSegment(
                index: index,
                rewardsModel: state.currentRewardsModel,
              );
            },
          );
        },
      ),
    );
  }
}
