import 'package:flutter/material.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

class ReelsPlayer extends StatefulWidget {
  final List<String> urlList;
  final int index;
  const ReelsPlayer({
    required this.urlList,
    required this.index,
    super.key,
  });

  @override
  State<ReelsPlayer> createState() => _ReelsPlayerState();
}

class _ReelsPlayerState extends State<ReelsPlayer> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    // _videoController = VideoPlayerController.networkUrl(
    //   Uri.parse(widget.urlList[widget.index]),
    // );
    initializePlayer();
    super.initState();
  }

  void initializePlayer() async {
    _videoController = VideoPlayerController.networkUrl(
        Uri.parse(widget.urlList[widget.index]));
    await _videoController.initialize();
    setState(() {
      _videoController.play();
      _videoController.setLooping(true);
    });
  }

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
          : Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.white.withOpacity(.8),
              child: Expanded(
                child: Container(color: Colors.grey),
              ),
            ),
    );
  }
}
