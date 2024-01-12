import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/repository/video_repository.dart';
import 'package:video_player/video_player.dart';
part 'preload_event.dart';
part 'preload_state.dart';

class PreloadBloc extends Bloc<PreloadEvent, PreloadState> {
  PreloadBloc() : super(PreloadState.initial()) {
    on<PreloadEvent>((event, emit) async {
      if (event.currentIndex == 0) {
        if (event.isInitial) {
          if (state.focusedIndex == 0) {
            await _initializeControllerAtIndex(0);
          }
          _playControllerAtIndex(0);
          await _initializeControllerAtIndex(1);
          emit(
            PreloadState(
                controllers: state.controllers,
                focusedIndex: event.currentIndex),
          );
        } else {
          _playPrevious(event.currentIndex);
          emit(
            PreloadState(
                controllers: state.controllers,
                focusedIndex: event.currentIndex),
          );
        }
      } else {
        if (event.currentIndex < state.focusedIndex) {
          _playPrevious(event.currentIndex);
          emit(
            PreloadState(
                controllers: state.controllers,
                focusedIndex: event.currentIndex),
          );
        } else {
          _playNext(event.currentIndex);
          emit(
            PreloadState(
                controllers: state.controllers,
                focusedIndex: event.currentIndex),
          );
        }
      }
    });
  }

  void _playNext(int index) {
    /// Stop [index - 1] controller
    _stopControllerAtIndex(index - 1);

    /// Dispose [index - 2] controller
    _disposeControllerAtIndex(index - 2);

    /// Play current video (already initialized)
    _playControllerAtIndex(index);

    /// Initialize [index + 1] controller
    _initializeControllerAtIndex(index + 1);
  }

  void _playPrevious(int index) {
    /// Stop [index + 1] controller
    _stopControllerAtIndex(index + 1);

    /// Dispose [index + 2] controller
    _disposeControllerAtIndex(index + 2);

    /// Play current video (already initialized)
    _playControllerAtIndex(index);

    /// Initialize [index - 1] controller
    _initializeControllerAtIndex(index - 1);
  }

  Future _initializeControllerAtIndex(int index) async {
    if (state.urls.length > index && index >= 0) {
      /// Create new controller
      final VideoPlayerController controller =
          VideoPlayerController.networkUrl(Uri.parse(state.urls[index]));

      /// Add to [controllers] list
      state.controllers[index] = controller;

      /// Initialize
      await controller.initialize();
    }
  }

  void _playControllerAtIndex(int index) {
    if (state.urls.length > index && index >= 0) {
      /// Get controller at [index]
      final VideoPlayerController controller = state.controllers[index]!;

      /// Play controller
      controller.play();
      controller.setLooping(true);
    }
  }

  void _stopControllerAtIndex(int index) {
    if (state.urls.length > index && index >= 0) {
      /// Get controller at [index]
      final VideoPlayerController controller = state.controllers[index]!;

      /// Pause
      controller.pause();

      /// Reset postiton to beginning
      controller.seekTo(const Duration());
    }
  }

  void _disposeControllerAtIndex(int index) {
    if (index == 0) {
      return;
    }
    if (state.urls.length > index && index >= 0) {
      /// Get controller at [index]
      final VideoPlayerController? controller = state.controllers[index];

      /// Dispose controller
      controller?.dispose();

      if (controller != null) {
        state.controllers.remove(index);
      }
    }
  }

  void disposeAllControllers() {
    state.controllers.forEach((key, value) {
      if (key != 0) {
        value.dispose();
      }
    });
    state.controllers.removeWhere(
      (key, value) => key != 0,
    );
  }
}
