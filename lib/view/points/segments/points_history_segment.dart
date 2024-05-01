import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point/bloc/points/points_bloc.dart';
import 'package:turning_point/bloc/points_history/points_history_bloc.dart';
import 'package:turning_point/helper/widget/custom_loading.dart';
import 'package:turning_point/view/points/segments/point_container.dart';

Future<void> _handleRefresh() async {
  pointsBloc.add(PointsLoadEvent());
  pointsHistoryBloc.add(PointsHistoryLoadEvent());
}

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
          return LiquidPullToRefresh(
            height: 60,
            animSpeedFactor: 2,
            showChildOpacityTransition: false,
            color: const Color(0xFFFFD700),
            backgroundColor: Colors.white,
            onRefresh: () => _handleRefresh(),
            child: SingleChildScrollView(
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
                  ],
                ),
              ),
            ),
          );
        case PointsHistoryLoadedState():
          return Expanded(
            child: Container(
              padding: EdgeInsets.only(
                // top: screenSize.height * .025,
                left: screenSize.width * .038,
                right: screenSize.width * .038,
              ),
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
                height: 60,
                animSpeedFactor: 2,
                showChildOpacityTransition: false,
                color: const Color.fromRGBO(89, 165, 255, 1),
                backgroundColor: Colors.white,
                onRefresh: () => _handleRefresh(),
                child: ListView.builder(
                  padding: EdgeInsets.only(top: screenSize.height * .021),
                  controller: scrollController,
                  itemCount: state.pointsHistoryModel!.length,
                  itemBuilder: (context, index) {
                    return pointContainer(
                      pointsHistoryModel: state.pointsHistoryModel![index],
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
