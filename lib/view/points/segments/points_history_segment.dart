import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point/bloc/points_history/points_history_bloc.dart';
import 'package:turning_point/view/points/segments/point_container.dart';

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
                const CircularProgressIndicator.adaptive(
                  strokeWidth: 5,
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation(Colors.amber),
                ),
              ],
            ),
          );

        case NoPointsHistoryState():
          return Center(
            child: Text(
              'No Points History',
              style: GoogleFonts.poppins(
                fontSize: screenSize.width * .05,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        case PointsHistoryLoadedState():
          if (state.pointsHistoryModel!.isNotEmpty) {
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
                ),
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
            );
          } else {
            return Center(
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
            );
          }
      }
    },
  );
}
