part of 'reels_bloc.dart';

sealed class ReelsState {
  List<ReelsModel>? reelsModelList;
  ReelsState({
    required this.reelsModelList,
  });
}

class ReelsLoadingState extends ReelsState {
  ReelsLoadingState({
    super.reelsModelList,
  });
}

class ReelsLoadedState extends ReelsState {
  ReelsLoadedState({
    required super.reelsModelList,
  });
}
