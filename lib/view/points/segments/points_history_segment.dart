part of '../points_screen.dart';

//====================Points History Segment====================//
Widget pointsHistorySegment({
  required Size screenSize,
  required ScrollController scrollController,
}) {
  return BlocBuilder<PointsHistoryBloc, PointsHistoryState>(
    builder: (context, state) {
      switch (state) {
//=====================Points History Loading State=====================//
        case PointsHistoryLoadingState():
          return Center(
            child: Column(
              children: [
                SizedBox(height: screenSize.height * .1),
                spinningLinesLoading(),
              ],
            ),
          );

//=====================No Points History State=====================//
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

//=====================Points History Loaded State=====================//
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

//=====================Points History Error State=====================//
        case PointsHistoryErrorState():
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenSize.height * .1),
              Lottie.asset(
                'assets/lottie/no_internet_animation.json',
                width: screenSize.width * .4,
              ),
              SizedBox(height: screenSize.height * .01),
              Text(
                'Something went wrong',
                style: GoogleFonts.roboto(
                  fontSize: screenSize.width * .035,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(18, 18, 18, 1),
                ),
              ),
              SizedBox(height: screenSize.height * .01),
              Text(
                'Check your internet connection\nor try again later',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: screenSize.width * .031,
                  color: const Color.fromRGBO(18, 18, 18, 18),
                ),
              ),
              SizedBox(height: screenSize.height * .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      pointsHistoryBloc.add(
                        PointsHistoryErrorStateReloadEvent(),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * .035,
                        vertical: screenSize.width * .01,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color.fromRGBO(18, 18, 18, 1),
                        ),
                      ),
                      child: Text(
                        'Refresh',
                        style: GoogleFonts.roboto(
                          fontSize: screenSize.width * .035,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(18, 18, 18, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * .005),
              SizedBox(
                height: screenSize.height * .035,
                child: Visibility(
                  visible: state.isLoading,
                  child: CupertinoActivityIndicator(
                    radius: screenSize.width * .026,
                  ),
                ),
              ),
            ],
          );
      }
    },
  );
}
