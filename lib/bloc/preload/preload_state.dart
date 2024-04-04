part of 'preload_bloc.dart';

class PreloadState {
  List<dynamic> urls = ReelsRepository.urlList;
  final Map<int, VideoPlayerController> controllers;
  final int focusedIndex;
  bool isReelsVisible = false;
  PreloadState({
    required this.controllers,
    required this.focusedIndex,
  });

  factory PreloadState.initial() => PreloadState(
        focusedIndex: 0,
        controllers: {},
      );
}
