import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/points_history/points_history_bloc.dart';
import 'package:turning_point/view/points/segments/point_container.dart';

//====================Points History Segment====================//
Widget pointsHistorySegment({required Size screenSize}) {
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
          return Expanded(
            child: Container(
              padding: EdgeInsets.only(
                top: screenSize.height * .025,
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
                itemCount: 10,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return pointContainer(
                    pointsHistoryModel: state.pointsHistoryModel![index],
                  );
                },
              ),
            ),
          );
        default:
          return Center(
            child: Text(
              'Something Went Wrong',
              style: GoogleFonts.poppins(
                fontSize: screenSize.width * .05,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
      }
    },
  );
}
