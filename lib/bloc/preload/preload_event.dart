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
