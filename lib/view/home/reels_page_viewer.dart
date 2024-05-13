// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
import 'package:turning_point/bloc/reels/reels_bloc.dart';
import 'package:turning_point/dialog/show_loading_dialog.dart';
import 'package:turning_point/dialog/show_points_received_toast.dart';
import 'package:turning_point/utilities/screen_size.dart';
import 'package:turning_point/utilities/widget/custom_loading.dart';
import 'package:turning_point/resources/reels_repository.dart';
import 'package:turning_point/view/home/reels_player.dart';
import 'package:turning_point/view/home/reels_screen.dart';
import 'package:vibration/vibration.dart';

class ReelsPageViewer extends StatefulWidget {
  const ReelsPageViewer({
    super.key,
  });

  @override
  State<ReelsPageViewer> createState() => ReelsPageViewerState();
}

class ReelsPageViewerState extends State<ReelsPageViewer>
    with SingleTickerProviderStateMixin {
  static late PageController pageController;
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  final reelsScreenState = ReelsScreenState();
  bool likeButtonActiveStatus = false;
  dynamic closeDialogHandle;
  final yellowShade = const Color(0xFFFFD700);

  @override
  void initState() {
    pageController =
        PageController(initialPage: preloadBloc.state.focusedIndex);

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    _animation = Tween<double>(
      begin: 1,
      end: 1.5,
    ).animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreloadBloc, PreloadState>(
      builder: (context, preloadState) {
        return BlocConsumer<ReelsBloc, ReelsState>(
          listener: (context, state) {
            if (state is ReelsLoadedState) {
              if (state.isLoading == true && closeDialogHandle == null) {
                closeDialogHandle = showLoadingDialog(
                  context: context,
                  loadingText: 'Downloading...',
                );
              } else if (state.isLoading != true && closeDialogHandle != null) {
                Navigator.pop(context);
                closeDialogHandle = null;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Video downloaded successfully'),
                  ),
                );
              }
            }
          },
          builder: (context, reelsState) {
            return PageView.builder(
              itemCount: preloadState.urls.length,
              onPageChanged: onPageChanged,
              scrollDirection: Axis.vertical,
              controller: pageController,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (preloadState.controllers.isNotEmpty &&
                    (index == preloadState.focusedIndex ||
                        index == preloadState.focusedIndex + 1 ||
                        index == preloadState.focusedIndex - 1)) {
                  return Stack(
                    children: [
                      ReelsPlayer(
                          videoController: preloadState.controllers[index]!),

                      //====================Rupee Icon====================//
                      Positioned(
                        right: screenSize.width * .03,
                        bottom: screenSize.height * .075,
                        child: Center(
                          child: Column(
                            children: [
                              ScaleTransition(
                                scale: _animation,
                                child: ValueListenableBuilder(
                                    valueListenable:
                                        preloadState.controllers[index]!,
                                    builder: (context, controllerValue, child) {
                                      //Determining Like button active status
                                      if (controllerValue.isCompleted) {
                                        reelsBloc.add(ReelLikeButtonEnableEvent(
                                            reelIndex: index));
                                        Future.delayed(Duration.zero, () {
                                          preloadState.controllers[index]!
                                              .play();
                                        });
                                      }

                                      return GestureDetector(
                                        onTap: () async {
                                          if (reelsState.isLikeButtonActive) {
                                            _animationController.forward();
                                            if (reelsState
                                                    .reelsModelList![index]
                                                    .isLiked !=
                                                true) {
                                              ReelsScreenState
                                                  .likeAnimationController
                                                  .forward();
                                              reelsBloc.add(ReelLikeEvent(
                                                  reelIndex: index));

                                              if (await Vibration
                                                      .hasVibrator() ==
                                                  true) {
                                                Vibration.vibrate(
                                                  duration: 100,
                                                );
                                              }
                                              showPointsReceivedToast(
                                                context: context,
                                                points: reelsState
                                                    .reelsModelList![index]
                                                    .points!,
                                              );
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: screenSize.width * .086,
                                          height: screenSize.width * .086,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.transparent,
                                            border: Border.all(
                                              color: reelsState
                                                      .isLikeButtonActive
                                                  ? reelsState
                                                              .reelsModelList![
                                                                  index]
                                                              .isLiked ==
                                                          true
                                                      ? yellowShade
                                                      : Colors.white
                                                  : Colors.grey,
                                              width: 2,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(.4),
                                                blurRadius: 1,
                                                blurStyle: BlurStyle.outer,
                                              )
                                            ],
                                          ),
                                          child: Center(
                                            child: Container(
                                              width: screenSize.width * .06,
                                              height: screenSize.width * .06,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.transparent,
                                                border: Border.all(
                                                  color: reelsState
                                                          .isLikeButtonActive
                                                      ? reelsState
                                                                  .reelsModelList![
                                                                      index]
                                                                  .isLiked ==
                                                              true
                                                          ? yellowShade
                                                          : Colors.white
                                                      : Colors.grey,
                                                  width: 2,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(.4),
                                                    blurRadius: 1,
                                                    blurStyle: BlurStyle.outer,
                                                  )
                                                ],
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.currency_rupee_rounded,
                                                  color: reelsState
                                                          .isLikeButtonActive
                                                      ? reelsState
                                                                  .reelsModelList![
                                                                      index]
                                                                  .isLiked ==
                                                              true
                                                          ? yellowShade
                                                          : Colors.white
                                                      : Colors.grey,
                                                  size: screenSize.width * .044,
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.black
                                                          .withOpacity(.8),
                                                      blurRadius: 1,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),

                              SizedBox(height: screenSize.height * .02),
                              //====================Download Icon====================//
                              GestureDetector(
                                onTap: () {
                                  reelsBloc
                                      .add(ReelDownloadEvent(reelIndex: index));
                                },
                                child: Icon(
                                  Icons.file_download_outlined,
                                  size: screenSize.width * .1,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(.8),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ValueListenableBuilder(
                          valueListenable: preloadState.controllers[index]!,
                          builder: (context, controllerValue, child) {
                            return Visibility(
                              visible: controllerValue.isInitialized,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: screenSize.height * .921,
                                ),
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: LinearPercentIndicator(
                                    padding: EdgeInsets.zero,
                                    animation: true,
                                    animateFromLastPercent: true,
                                    animationDuration: 500,
                                    backgroundColor: Colors.transparent,
                                    progressColor: controllerValue
                                                .position.inMilliseconds >
                                            100
                                        ? Colors.red
                                        : Colors.transparent,
                                    percent: (controllerValue
                                                    .position.inMilliseconds /
                                                (controllerValue
                                                    .duration.inMilliseconds)) >
                                            1.0
                                        ? 0
                                        : (controllerValue
                                                .position.inMilliseconds /
                                            (controllerValue
                                                .duration.inMilliseconds)),
                                    barRadius: const Radius.circular(6),
                                    lineHeight: 3,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  );
                } else {
                  return circleLoading();
                }
              },
            );
          },
        );
      },
    );
  }

  void onPageChanged(index) async {
    likeButtonActiveStatus = false;
    preloadBloc.manuallyPaused = false;
    preloadBloc.add(PreloadEvent(currentIndex: index));
    if (index >= preloadBloc.pageIndex * ReelsRepository.reelsPageSize - 2) {
      preloadBloc.pageIndex++;
      await ReelsRepository.getReels(page: preloadBloc.pageIndex);
    }
  }
}
