import 'package:flutter/material.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
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
    if (preloadBloc.manuallyPaused) {
      animationController.forward();
    }
    super.initState();
  }

  void onScreenTap() {
    if (!preloadBloc.state.isReelsVisible) {
      preloadBloc.add(ReelsScreenToggleEvent(isReelsVisible: true));
    }
    if (widget.videoController.value.isPlaying) {
      widget.videoController.pause();
      animationController.forward();
      preloadBloc.manuallyPaused = true;
    } else {
      widget.videoController.play();
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
        if (!preloadBloc.manuallyPaused) {
          animationController.reverse();
        }
        if (value.isPlaying) {
          animationController.reverse();
          preloadBloc.manuallyPaused = false;
        }

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
      },
    );
  }
}
