part of 'reels_bloc.dart';

sealed class ReelsState {
  final UserModelResponse? userModel;

  ReelsState(this.userModel);
}

class InitialReelState extends ReelsState {
  InitialReelState(super.userModel);
}

class LikeButtonActiveState extends ReelsState {
  LikeButtonActiveState(super.userModel);
}

class ReelLikedState extends ReelsState {
  ReelLikedState(super.userModel);
}

// class ReelUnlikedState extends ReelsState {
//   ReelUnlikedState({required super.reelsMap});
// }
