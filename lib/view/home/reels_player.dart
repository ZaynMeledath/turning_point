import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
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
  void initState() {
    log('CONTROLLER DATASOURCE: ${widget.videoController.dataSource}');
    // _videoController = VideoPlayerController.networkUrl(
    //   Uri.parse(widget.urlList[widget.index]),
    // );
    // _videoController = VideoPlayerController.asset('assets/videos/reel.mp4');
    // initializePlayer();

    widget.videoController.addListener(() {
      if (widget.videoController.value.isInitialized) {
        setState(() {});
      }
    });
    super.initState();
  }

  // void initializePlayer() async {
  //   // _videoController = VideoPlayerController.networkUrl(
  //   //     Uri.parse(widget.urlList[widget.index]));
  //   await _videoController.initialize();
  //   setState(() {
  //     _videoController.play();
  //     _videoController.setLooping(true);
  //   });
  // }

// //====================Initialize Video Player====================//
//   void initializePlayer() async {
//     final urlList = widget.urlList;
//     final index = widget.index;
//     final fileInfo = await checkForCache(urlList[index]);

//     if (fileInfo == null) {
// //====================Video is Loaded from network since it is not in cache====================//
//       _videoController =
//           VideoPlayerController.networkUrl(Uri.parse(urlList[index]));
//       await _videoController.initialize();
//       setState(() {
//         _videoController.play();
//         _videoController.setLooping(true);
//       });
//       cacheVideo(urlList);
//     } else {
// //====================Video is loaded from file since it is downloaded in cache====================//
//       final file = fileInfo.file;
//       _videoController = VideoPlayerController.file(file);
//       await _videoController.initialize();
//       setState(() {
//         _videoController.play();
//         _videoController.setLooping(true);
//       });
//     }
//   }

// //====================Check for Cached Video====================//
//   Future<FileInfo?> checkForCache(String url) async {
//     final FileInfo? result = await DefaultCacheManager().getFileFromCache(url);
//     return result;
//   }

// //====================Cache Video====================//
//   void cacheVideo(List<String> urlList) async {
//     for (int i = 0; i < 3; i++) {
//       final fileInfo = await DefaultCacheManager()
//           .getFileFromCache(urlList[widget.index + i]);

//       if (fileInfo == null) {
//         await DefaultCacheManager().getSingleFile(urlList[widget.index + i]);
//       }
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: widget.videoController.value.isInitialized
          ? VideoPlayer(widget.videoController)
          : const CircularProgressIndicator.adaptive(
              strokeWidth: 5,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation(Colors.pink),
            ),
    );
  }
}
