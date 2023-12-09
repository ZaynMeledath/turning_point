import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReelsPlayer extends StatefulWidget {
  final String url;
  const ReelsPlayer({
    required this.url,
    super.key,
  });

  @override
  State<ReelsPlayer> createState() => _ReelsPlayerState();
}

class _ReelsPlayerState extends State<ReelsPlayer> {
  late final VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        setState(() {
          _videoController.play();
          _videoController.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _videoController.value.isInitialized
          ? Expanded(
              child: VideoPlayer(_videoController),
            )
          : const Center(
              child: CircularProgressIndicator(
              color: Colors.grey,
            )),
    );
  }
}
