part of '../points_screen.dart';

//====================Points History Segment====================//
Widget pointsHistorySegment({
  required Size screenSize,
  required ScrollController scrollController,
}) {
  return BlocBuilder<PointsHistoryBloc, PointsHistoryState>(
    builder: (context, state) {
      switch (state) {
        case PointsHistoryLoadingState():
          return Center(
            child: Column(
              children: [
                SizedBox(height: screenSize.height * .1),
                spinningLinesLoading(),
              ],
            ),
          );

        case NoPointsHistoryState():
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: screenSize.height * .06),
                  Lottie.asset(
                    'assets/lottie/no_data_animation.json',
                    width: screenSize.width * .52,
                  ),
                  Text(
                    'Earn Points to show the history',
                    style: GoogleFonts.inter(
                      fontSize: screenSize.width * .04,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(.75),
                    ),
                  ),
                  SizedBox(height: screenSize.height * .1),
                ],
              ),
            ),
          );
        case PointsHistoryLoadedState():
          return Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(245, 246, 250, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
              ),
              child: LiquidPullToRefresh(
                onRefresh: () => handlePointsScreenRefresh(),
                animSpeedFactor: 2,
                height: 50,
                showChildOpacityTransition: false,
                color: const Color(0xFFFFD700),
                backgroundColor: Colors.white,
                child: ListView.builder(
                  padding: EdgeInsets.only(top: screenSize.height * .021),
                  controller: scrollController,
                  itemCount: state.pointsHistoryModel!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        // top: screenSize.height * .025,
                        left: screenSize.width * .038,
                        right: screenSize.width * .038,
                      ),
                      child: pointContainer(
                        pointsHistoryModel: state.pointsHistoryModel![index],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
      }
    },
  );
}
