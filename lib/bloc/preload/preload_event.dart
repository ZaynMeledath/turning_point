part of 'preload_bloc.dart';

class PreloadEvent {
  final int currentIndex;
  final bool isInitial;
  PreloadEvent({
    required this.currentIndex,
    required this.isInitial,
  });
}

class PreloadResetEvent extends PreloadEvent {
  PreloadResetEvent()
      : super(
          currentIndex: 0,
          isInitial: true,
        );
}
