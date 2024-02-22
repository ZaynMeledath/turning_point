part of 'reels_bloc.dart';

sealed class ReelsState {
  int points;
  List<ReelsModel>? reelsModel;
  ReelsState({
    required this.points,
    required this.reelsModel,
  });
}

class InitialReelState extends ReelsState {
  InitialReelState({
    required super.points,
    required super.reelsModel,
  });
}

class LikeButtonActiveState extends ReelsState {
  LikeButtonActiveState({
    required super.points,
    required super.reelsModel,
  });
}

class ReelLikedState extends ReelsState {
  ReelLikedState({
    required super.points,
    required super.reelsModel,
  });
}
