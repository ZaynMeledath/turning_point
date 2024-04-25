import 'package:flutter/material.dart';
import 'package:turning_point/bloc/points_history/points_history_bloc.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
import 'package:turning_point/helper/widget/my_app_bar.dart';
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
  late final ScrollController scrollController;
  int page = 1;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        pointsHistoryBloc.add(PointsHistoryLoadEvent());
      }
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    preloadBloc.add(ReelsScreenToggleEvent(isReelsVisible: false));
    if (preloadBloc.state.controllers.isNotEmpty) {
      preloadBloc.pauseCurrentController();
    }
    disableWakeLock();
    super.didChangeDependencies();
  }

  void disableWakeLock() {
    setState(() {
      WakelockPlus.disable();
    });
  }

  @override
  void dispose() {
    if (widget.directEntry == true) {
      preloadBloc.add(ReelsScreenToggleEvent(isReelsVisible: true));
      if (preloadBloc.state.controllers.isNotEmpty &&
          !preloadBloc.manuallyPaused) {
        Future.delayed(
          Duration.zero,
          () {
            preloadBloc.add(
              PreloadEvent(
                currentIndex: preloadBloc.state.focusedIndex,
              ),
            );
          },
        );
      }
    }
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (preloadBloc.state.controllers.isNotEmpty) {
      preloadBloc.pauseCurrentController();
    }
    preloadBloc.add(ReelsScreenToggleEvent(isReelsVisible: false));
    pointsHistoryBloc.add(PointsHistoryLoadEvent());
    return Scaffold(
      appBar: myAppBar(
        context: context,
        title: 'Points',
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
//====================Header Segment with Back Button and Title====================//

//====================Body Segment====================//
            SizedBox(height: screenSize.height * .015),
            availablePointsSegment(context: context),
            SizedBox(height: screenSize.height * .024),
            pointsHistorySegment(
              screenSize: screenSize,
              scrollController: scrollController,
            ),
          ],
        ),
      ),
    );
  }
}
