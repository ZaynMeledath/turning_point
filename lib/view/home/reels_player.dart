import 'package:flutter/material.dart';
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

class _ReelsPlayerState extends State<ReelsPlayer> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.videoController,
        builder: (context, value, child) {
          return Center(
            child: value.isInitialized
                ? VideoPlayer(widget.videoController)
                : circleLoading(),
          );
        });
  }
}
