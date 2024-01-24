part of 'reels_bloc.dart';

sealed class ReelsState {}

class InitialReelState extends ReelsState {}

class ReelLikedState extends ReelsState {}

// class ReelUnlikedState extends ReelsState {
//   ReelUnlikedState({required super.reelsMap});
// }
