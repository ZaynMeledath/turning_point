import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:turning_point/bloc/points/points_bloc.dart';
import 'package:turning_point/bloc/points_history/points_history_bloc.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/helper/custom_navigator.dart';
import 'package:turning_point/helper/widget/custom_loading.dart';
import 'package:turning_point/helper/widget/my_app_bar.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/model/points_history_model.dart';
import 'package:turning_point/view/redeem/redeem_screen.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

part 'segments/available_points_segment.dart';
part 'segments/point_container.dart';
part 'segments/points_history_segment.dart';

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
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    if (widget.directEntry == true) {
      WakelockPlus.enable();
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
//====================App Bar====================//
      appBar: myAppBar(
        context: context,
        title: 'Points',
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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

Future<void> handlePointsScreenRefresh() async {
  profileBloc.add(ProfileLoadEvent(avoidGettingFromPreference: true));
  pointsHistoryBloc.add(PointsHistoryLoadEvent());
}
