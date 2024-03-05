// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
import 'package:turning_point/bloc/reels/reels_bloc.dart';
import 'package:turning_point/dialog/show_points_received_dialog.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_loading.dart';
import 'package:turning_point/model/user_model.dart';
import 'package:turning_point/view/home/reels_player.dart';
import 'package:turning_point/view/home/reels_screen.dart';
import 'package:vibration/vibration.dart';

class ReelsPageViewer extends StatefulWidget {
  final UserModel user;
  const ReelsPageViewer({
    required this.user,
    super.key,
  });

  @override
  State<ReelsPageViewer> createState() => ReelsPageViewerState();
}

class ReelsPageViewerState extends State<ReelsPageViewer>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  final reelsScreenState = ReelsScreenState();

  @override
  void initState() {
    _pageController =
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
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    preloadBloc.add(PreloadEvent(
        currentIndex: preloadBloc.state.focusedIndex, isInitial: true));
    reelsBloc.add(ReelLoadEvent(reelIndex: preloadBloc.state.focusedIndex));
    return BlocBuilder<PreloadBloc, PreloadState>(
      builder: (context, state) {
        final user = widget.user;
        return PageView.builder(
          itemCount: state.urls.length,
          itemBuilder: (context, index) {
            if (state.controllers.isNotEmpty) {
              return Stack(
                children: [
                  ReelsPlayer(videoController: state.controllers[index]!),

                  //====================Rupee Icon====================//
                  Positioned(
                    right: screenSize.width * .03,
                    bottom: screenSize.height * .075,
                    child: Center(
                      child: Column(
                        children: [
                          BlocBuilder<ReelsBloc, ReelsState>(
                            builder: (context, state) {
                              return ScaleTransition(
                                scale: _animation,
                                child: GestureDetector(
                                  onTap: () async {
                                    if (state.reelsModelList![index]
                                        .isLikeButtonActive) {
                                      _animationController.forward();
                                      if (state
                                              .reelsModelList![index].isLiked !=
                                          true) {
                                        // AudioPlayer().play(
                                        //   volume: 100,
                                        //   AssetSource(
                                        //       'sounds/success_sound.mp3'),
                                        // );
                                        ReelsScreenState.animationController
                                            .forward();
                                        reelsBloc.add(
                                            ReelLikeEvent(reelIndex: index));

                                        if (await Vibration.hasVibrator() ==
                                            true) {
                                          Vibration.vibrate(
                                            duration: 100,
                                          );
                                        }
                                      }

                                      if (user.points == 0) {
                                        showPointsReceivedDialog(
                                          context: context,
                                          points: state
                                              .reelsModelList![index].points!,
                                        );
                                      }
                                    }

                                    // if (state.reelsModelList![index].isLiked ==
                                    //     true) {
                                    //   _animationController.forward();
                                    // }
                                  },
                                  child: Image.asset(
                                    'assets/icons/rupee_icon.png',
                                    width: screenSize.width * .105,
                                    height: screenSize.width * .105,
                                    color: state.reelsModelList![index]
                                            .isLikeButtonActive
                                        ? state.reelsModelList![index]
                                                    .isLiked ==
                                                true
                                            ? const Color.fromRGBO(
                                                255, 215, 0, 1)
                                            : Colors.white
                                        : Colors.grey,
                                  ),
                                ),
                              );
                            },
                          ),

                          SizedBox(height: screenSize.height * .02),
                          //====================Download Icon====================//
                          GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.file_download_outlined,
                              size: screenSize.width * .09,
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
                ],
              );
            } else {
              return spinningLinesLoading();
            }
          },
          onPageChanged: (index) {
            reelsBloc.add(ReelLoadEvent(reelIndex: index));
            context
                .read<PreloadBloc>()
                .add(PreloadEvent(currentIndex: index, isInitial: false));
          },
          scrollDirection: Axis.vertical,
          controller: _pageController,
          physics: const BouncingScrollPhysics(),
        );
      },
    );
  }
}
