import 'package:flutter/material.dart';
import 'package:turning_point/utils/screen_size.dart';
import 'package:turning_point/utils/widget/custom_loading.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

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
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));

    animation = Tween<double>(
      begin: 0,
      end: 1.4,
    ).animate(animationController);

    super.initState();
  }

  void onScreenTap() {
    if (widget.videoController.value.isPlaying) {
      widget.videoController.pause();
      animationController.forward();
      Future.delayed(const Duration(milliseconds: 600), () {
        animationController.reverse();
      });
    } else {
      widget.videoController.play();
      animationController.forward();
      Future.delayed(const Duration(milliseconds: 600), () {
        animationController.reverse();
      });
    }
  }

  @override
  void dispose() {
    animationController.reverse();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WakelockPlus.enable();
    return ValueListenableBuilder(
      valueListenable: widget.videoController,
      builder: (context, value, child) {
        // if (!preloadBloc.manuallyPaused) {
        //   animationController.reverse();
        // }
        // if (value.isPlaying) {
        //   animationController.reverse();
        //   preloadBloc.manuallyPaused = false;
        // }

        return Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child:
                  value.isInitialized || (value.isPlaying && !value.isBuffering)
                      ? GestureDetector(
                          onTapDown: (details) {
                            onScreenTap();
                          },
                          child: VideoPlayer(
                            widget.videoController,
                          ),
                        )
                      : circleLoading(),
            ),
            ScaleTransition(
              scale: animation,
              child: GestureDetector(
                onTap: () => onScreenTap(),
                child: Container(
                  width: screenSize.width * .105,
                  height: screenSize.width * .105,
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    value.isPlaying ? Icons.play_arrow : Icons.pause,
                    size: screenSize.width * .052,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}



// Icon(
//                   value.isPlaying
//                       ? Icons.play_circle_filled_rounded
//                       : Icons.pause_circle_filled_rounded,
//                   size: screenSize.width * .125,
//                   color: Colors.white.withOpacity(.8),
//                   shadows: [
//                     Shadow(
//                       blurRadius: 1,
//                       color: Colors.grey.withOpacity(.3),
//                     ),
//                   ],
//                 ),
