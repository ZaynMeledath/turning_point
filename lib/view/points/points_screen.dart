import 'package:flutter/material.dart';
import 'package:turning_point/bloc/points_history/points_history_bloc.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
import 'package:turning_point/helper/widget/custom_app_bar.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/points/segments/available_points_segment.dart';
import 'package:turning_point/view/points/segments/points_history_segment.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class PointsScreen extends StatefulWidget {
  final bool? directEntry;
  const PointsScreen({
    super.key,
    this.directEntry, // Will be removed while optmizing the code
  });

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
  @override
  void initState() {
    preloadBloc.state.isReelsVisible = false;
    if (preloadBloc.state.controllers.isNotEmpty) {
      preloadBloc.pauseCurrentController();
    }
    WakelockPlus.disable();
    super.initState();
  }

  @override
  void dispose() {
    if (widget.directEntry == true) {
      preloadBloc.state.isReelsVisible = true;
      if (preloadBloc.state.controllers.isNotEmpty &&
          !preloadBloc.manuallyPaused) {
        preloadBloc.playCurrentController();
      }
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pointsHistoryBloc.add(PointsHistoryLoadEvent());
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
//====================Header Segment with Back Button and Title====================//
            customAppBar(
              context: context,
              title: 'Points',
            ),

//====================Body Segment====================//
            SizedBox(height: screenSize.height * .015),
            availablePointsSegment(context: context),
            SizedBox(height: screenSize.height * .024),
            pointsHistorySegment(screenSize: screenSize),
          ],
        ),
      ),
    );
  }
}
