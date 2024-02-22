part of 'preload_bloc.dart';

class PreloadEvent {
  final int currentIndex;
  final bool isInitial;
  PreloadEvent({
    required this.currentIndex,
    required this.isInitial,
  });
}
