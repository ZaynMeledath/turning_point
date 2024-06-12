part of 'reels_bloc.dart';

sealed class ReelsState {
  List<ReelsModel>? reelsModelList;
  final bool isLikeButtonActive;
  // final bool? isDownloading;
  ReelsState({
    required this.reelsModelList,
    required this.isLikeButtonActive,
    // required this.isDownloading,
  });
}

class ReelsLoadingState extends ReelsState {
  ReelsLoadingState({
    super.reelsModelList,
  }) : super(
          isLikeButtonActive: false,
          // isDownloading: false,
        );
}

class ReelsLoadedState extends ReelsState {
  ReelsLoadedState({
    required super.reelsModelList,
    required super.isLikeButtonActive,
    // super.isDownloading,
  });
}
