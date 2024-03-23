part of 'reels_bloc.dart';

sealed class ReelsState {
  List<ReelsModel>? reelsModelList;
  final bool isLikeButtonActive;
  ReelsState({
    required this.reelsModelList,
    required this.isLikeButtonActive,
  });
}

class ReelsLoadingState extends ReelsState {
  ReelsLoadingState({
    super.reelsModelList,
  }) : super(isLikeButtonActive: false);
}

class ReelsLoadedState extends ReelsState {
  final bool? isLoading;
  ReelsLoadedState({
    required super.reelsModelList,
    this.isLoading,
    required super.isLikeButtonActive,
  });
}
