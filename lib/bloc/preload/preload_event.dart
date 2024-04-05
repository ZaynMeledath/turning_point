part of 'preload_bloc.dart';

class PreloadEvent {
  final int currentIndex;
  final bool isInitial;
  final bool? isReloading;
  PreloadEvent({
    required this.currentIndex,
    required this.isInitial,
    this.isReloading,
  });
}

class PreloadResetEvent extends PreloadEvent {
  PreloadResetEvent()
      : super(
          currentIndex: 0,
          isInitial: true,
        );
}

class ReelsScreenToggleEvent extends PreloadEvent {
  final bool isReelsVisible;
  ReelsScreenToggleEvent({
    required this.isReelsVisible,
  }) : super(
          isInitial: false,
          currentIndex: preloadBloc.state.focusedIndex,
        );
}
