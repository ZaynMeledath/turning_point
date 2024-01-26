import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
import 'package:turning_point/bloc/reels/reels_bloc.dart';
import 'package:turning_point/dialog/show_points_received_dialog.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/model/user_model.dart';
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

class ReelsPageViewerState extends State<ReelsPageViewer>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  bool rupeeScaled = false;

  @override
  void initState() {
    _pageController = PageController();

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
    context
        .read<PreloadBloc>()
        .add(PreloadEvent(currentIndex: 0, isInitial: true));
    context.read<ReelsBloc>().add(ReelLoadEvent(reelIndex: 0));

    return BlocBuilder<PreloadBloc, PreloadState>(
      builder: (context, state) {
        final user = widget.user;
        return PageView.builder(
          itemCount: state.urls.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                ReelsPlayer(videoController: state.controllers[index]!),

                //====================Rupee Icon====================//
                BlocBuilder<ReelsBloc, ReelsState>(
                  builder: (context, state) {
                    return Positioned(
                      right: screenSize.width * .03,
                      bottom: screenSize.height * .14,
                      child: ScaleTransition(
                        scale: _animation,
                        child: GestureDetector(
                          onTap: () {
                            if (state is LikeButtonActiveState) {
                              _animationController.forward();

                              context
                                  .read<ReelsBloc>()
                                  .add(ReelLikeEvent(reelIndex: index));

                              if (user.data!.points == 0) {
                                showPointsReceivedDialog(context: context);
                              }
                            }
                          },
                          child: Image.asset(
                            'assets/icons/rupee_icon.png',
                            width: screenSize.width * .081,
                            height: screenSize.width * .081,
                            color: state is ReelLikedState
                                ? const Color.fromRGBO(255, 215, 0, 1)
                                : state is LikeButtonActiveState
                                    ? Colors.white
                                    : Colors.grey,
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
            context.read<ReelsBloc>().add(ReelLoadEvent(reelIndex: index));
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
