part of 'preload_bloc.dart';

class PreloadEvent {
  final int currentIndex;
  PreloadEvent({
    required this.currentIndex,
  });
}

class PreloadResetEvent extends PreloadEvent {
  PreloadResetEvent()
      : super(
          currentIndex: 0,
        );
}

class ReelsScreenToggleEvent extends PreloadEvent {
  final bool isReelsVisible;
  ReelsScreenToggleEvent({
    required this.isReelsVisible,
  }) : super(
          currentIndex: preloadBloc.state.focusedIndex,
        );
}
