part of 'reels_bloc.dart';

@immutable
sealed class ReelsEvent {
  final int reelIndex;
  const ReelsEvent({required this.reelIndex});
}

class ReelLoadEvent extends ReelsEvent {
  const ReelLoadEvent({required super.reelIndex});
}

class ReelLikeEvent extends ReelsEvent {
  const ReelLikeEvent({required super.reelIndex});
}

class ReelDownloadEvent extends ReelsEvent {
  const ReelDownloadEvent({required super.reelIndex});

}
