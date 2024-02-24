part of 'reels_bloc.dart';

sealed class ReelsState {
  int? userPoints;
  List<ReelsModel>? reelsModelList;
  ReelsState({
    required this.userPoints,
    required this.reelsModelList,
  });
}

class ReelsLoadingState extends ReelsState {
  ReelsLoadingState({
    super.userPoints,
    super.reelsModelList,
  });
}

class ReelsLoadedState extends ReelsState {
  ReelsLoadedState({
    required super.userPoints,
    required super.reelsModelList,
  });
}
