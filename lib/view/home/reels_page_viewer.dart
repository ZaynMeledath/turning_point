import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
import 'package:turning_point/bloc/reels/reels_bloc.dart';
import 'package:turning_point/dialog/show_points_received_dialog.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/model/user_model.dart';
import 'package:turning_point/resources/reel_repository.dart';
import 'package:turning_point/view/home/reels_player.dart';

class ReelsPageViewer extends StatefulWidget {
  final UserModel user;
  const ReelsPageViewer({
    required this.user,
    super.key,
  });

  @override
  State<ReelsPageViewer> createState() => ReelsPageViewerState();
}

class ReelsPageViewerState extends State<ReelsPageViewer> {
  late final PageController _pageController;

  bool rupeeClicked = false;
  bool rupeeScaled = false;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<PreloadBloc>()
        .add(PreloadEvent(currentIndex: 0, isInitial: true));
    context.read<ReelsBloc>().add(ReelLoadEvent(reelIndex: 0));
    return StreamBuilder<Map<String, dynamic>>(
        stream: ReelRepository.reelsStreamController.stream,
        builder: (context, snapshot) {
          return BlocBuilder<PreloadBloc, PreloadState>(
            builder: (context, state) {
              final user = widget.user;
              return PageView.builder(
                itemCount: state.urls.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      snapshot.hasData
                          ? ReelsPlayer(
                              videoController: state.controllers[index]!)
                          : const Center(
                              child: CircularProgressIndicator.adaptive(
                                strokeWidth: 5,
                                backgroundColor: Colors.white,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.amber),
                              ),
                            ),

                      //====================Rupee Icon====================//
                      BlocBuilder<ReelsBloc, ReelsState>(
                        builder: (context, state) {
                          return Positioned(
                            right: screenSize.width * .03,
                            bottom: screenSize.height * .14,
                            child: AnimatedScale(
                              scale: rupeeScaled ? 1.5 : 1,
                              duration: const Duration(milliseconds: 200),
                              child: GestureDetector(
                                onTap: () {
                                  context
                                      .read<ReelsBloc>()
                                      .add(ReelLikeEvent(reelIndex: index));
                                  if (user.data!.points == 0) {
                                    showPointsReceivedDialog(context: context);
                                  }

                                  // setState(() {
                                  //   rupeeClicked = true;
                                  //   rupeeScaled = true;
                                  // });
                                  // Future.delayed(const Duration(milliseconds: 200),
                                  //     () {
                                  //   setState(() {
                                  //     rupeeScaled = false;
                                  //   });
                                  // });
                                },
                                child: Image.asset(
                                  'assets/icons/rupee_icon.png',
                                  width: screenSize.width * .081,
                                  height: screenSize.width * .081,
                                  color: state is ReelLikedState
                                      ? const Color.fromRGBO(255, 215, 0, 1)
                                      : Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      //====================Download Icon====================//
                      Positioned(
                        right: screenSize.width * .03,
                        bottom: screenSize.height * .075,
                        child: GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.file_download_outlined,
                            size: 35,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 2),
                                color: Colors.grey,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
                onPageChanged: (index) {
                  context
                      .read<PreloadBloc>()
                      .add(PreloadEvent(currentIndex: index, isInitial: false));
                  context
                      .read<ReelsBloc>()
                      .add(ReelLoadEvent(reelIndex: index));
                },
                scrollDirection: Axis.vertical,
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
              );
            },
          );
        });
  }
}
