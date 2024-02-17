part of 'reels_bloc.dart';

sealed class ReelsState {
  final int points;
  ReelsState({required this.points});
}

class InitialReelState extends ReelsState {
  InitialReelState({required super.points});
}

class LikeButtonActiveState extends ReelsState {
  LikeButtonActiveState({required super.points});
}

class ReelLikedState extends ReelsState {
  ReelLikedState({required super.points});
}
