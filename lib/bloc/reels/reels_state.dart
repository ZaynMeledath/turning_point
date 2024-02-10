part of 'reels_bloc.dart';

sealed class ReelsState {}

class InitialReelState extends ReelsState {}

class LikeButtonActiveState extends ReelsState {}

class ReelLikedState extends ReelsState {}
