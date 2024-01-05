part of 'preload_bloc.dart';

class PreloadState {
  final List<String> urls = VideoRepository.urlList;
  final Map<int, VideoPlayerController> controllers;
  final int focusedIndex;
  PreloadState({
    required this.controllers,
    required this.focusedIndex,
  });

  factory PreloadState.initial() => PreloadState(
        focusedIndex: 0,
        controllers: {
          0: VideoPlayerController.networkUrl(
              Uri.parse(VideoRepository.urlList[0]))
        },
      );
}
