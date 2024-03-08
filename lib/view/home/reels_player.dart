import 'package:flutter/material.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_loading.dart';
import 'package:video_player/video_player.dart';

class ReelsPlayer extends StatefulWidget {
  final VideoPlayerController videoController;
  const ReelsPlayer({
    required this.videoController,
    super.key,
  });

  @override
  State<ReelsPlayer> createState() => _ReelsPlayerState();
}

class _ReelsPlayerState extends State<ReelsPlayer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));

    animation = Tween<double>(
      begin: 0,
      end: 1.4,
    ).animate(animationController);
  }

  void onScreenTap() {
    if (widget.videoController.value.isPlaying) {
      widget.videoController.pause();
      animationController.forward();
      preloadBloc.manuallyPaused = true;
    } else {
      widget.videoController.play();
      animationController.reverse();
      preloadBloc.manuallyPaused = false;
    }
  }

  @override
  void deactivate() {
    animationController.reset();
    super.deactivate();
  }

  // void showIconOverlay() {
  //   final overlayEntry = OverlayEntry(builder: (context) {
  //     return Icon(
  //       isMute ? Icons.volume_off : Icons.volume_up,
  //       size: 70.0,
  //       color: Colors.white.withOpacity(.8),
  //     );
  //   });

  //   Overlay.of(context).insert(overlayEntry);

  //   // Set a timer to remove the overlay
  //   Timer(const Duration(milliseconds: 750), () {
  //     overlayEntry.remove();
  //     overlayEntry.dispose();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.videoController,
        builder: (context, value, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: value.isInitialized
                    ? GestureDetector(
                        onTap: () {
                          onScreenTap();
                        },
                        child: VideoPlayer(widget.videoController),
                      )
                    : circleLoading(),
              ),
              ScaleTransition(
                scale: animation,
                child: GestureDetector(
                  onTap: () => onScreenTap(),
                  child: Icon(
                    Icons.play_circle_fill_rounded,
                    size: screenSize.width * .13,
                    color: Colors.white.withOpacity(.8),
                    shadows: [
                      Shadow(
                        blurRadius: 1,
                        color: Colors.grey.withOpacity(.3),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
