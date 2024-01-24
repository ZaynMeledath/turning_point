part of 'reels_bloc.dart';

sealed class ReelsEvent {
  final int reelIndex;
  ReelsEvent({required this.reelIndex});
}

class ReelLoadEvent extends ReelsEvent {
  ReelLoadEvent({required super.reelIndex});
}

class ReelLikeEvent extends ReelsEvent {
  ReelLikeEvent({required super.reelIndex});
}
