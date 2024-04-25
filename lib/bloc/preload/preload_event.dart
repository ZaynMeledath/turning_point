part of 'preload_bloc.dart';

class PreloadEvent {
  final int currentIndex;
  bool? isInitial;
  bool? isReloading;
  PreloadEvent({
    required this.currentIndex,
    this.isInitial,
    this.isReloading,
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
