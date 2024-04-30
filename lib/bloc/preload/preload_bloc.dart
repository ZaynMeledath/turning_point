import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/bloc/reels/reels_bloc.dart';
import 'package:turning_point/resources/reels_repository.dart';
import 'package:turning_point/view/home/reels_page_viewer.dart';
import 'package:video_player/video_player.dart';
part 'preload_event.dart';
part 'preload_state.dart';

class PreloadBloc extends Bloc<PreloadEvent, PreloadState> {
  bool manuallyPaused = false; // Will be removed while optimizing the app
  int pageIndex = 1;
  PreloadBloc() : super(PreloadState.initial()) {
    on<PreloadEvent>((event, emit) async {
      state.urls = ReelsRepository.urlList;
      if (state.isReelsVisible) {
        if (event.currentIndex == 0) {
          if (state.controllers.isEmpty || event.isReloading == true) {
            _initializeControllerAtIndex(0)
                .then((value) => _playControllerAtIndex(0));
            emit(
              PreloadState(
                controllers: state.controllers,
                focusedIndex: event.currentIndex,
                isReelsVisible: state.isReelsVisible,
              ),
            );

            await _initializeControllerAtIndex(1);
            emit(
              PreloadState(
                controllers: state.controllers,
                focusedIndex: event.currentIndex,
                isReelsVisible: state.isReelsVisible,
              ),
            );
          } else {
            if (state.controllers.length == 1) {
              _playControllerAtIndex(0);
              emit(
                PreloadState(
                  controllers: state.controllers,
                  focusedIndex: event.currentIndex,
                  isReelsVisible: state.isReelsVisible,
                ),
              );
            } else {
              _playPrevious(event.currentIndex);
              emit(
                PreloadState(
                  controllers: state.controllers,
                  focusedIndex: event.currentIndex,
                  isReelsVisible: state.isReelsVisible,
                ),
              );
            }
          }
        } else {
          if (state.controllers.isEmpty) {
            ReelsRepository.urlList.clear();
            ReelsPageViewerState.pageController.jumpToPage(0);
            await ReelsRepository.getReels(page: 1);
            preloadBloc.add(
              PreloadEvent(
                currentIndex: 0,
              ),
            );
          }
          //To ensure that video is not played whenever the profile load event is called

          if (event.currentIndex < state.focusedIndex) {
            _playPrevious(event.currentIndex);
            emit(
              PreloadState(
                controllers: state.controllers,
                focusedIndex: event.currentIndex,
                isReelsVisible: state.isReelsVisible,
              ),
            );
          } else if (event.currentIndex > state.focusedIndex) {
            _playNext(event.currentIndex);
            emit(
              PreloadState(
                controllers: state.controllers,
                focusedIndex: event.currentIndex,
                isReelsVisible: state.isReelsVisible,
              ),
            );
          } else {
            _playControllerAtIndex(event.currentIndex);
            emit(
              PreloadState(
                controllers: state.controllers,
                focusedIndex: event.currentIndex,
                isReelsVisible: state.isReelsVisible,
              ),
            );
          }
        }
        return reelsBloc
            .add(ReelLoadEvent(reelIndex: preloadBloc.state.focusedIndex));
      }
    });

    on<PreloadResetEvent>((event, emit) {
      pageIndex = 1;
      ReelsRepository.urlList.clear();
      disposeAllControllers();
      return emit(PreloadState.initial());
    });

    on<ReelsScreenToggleEvent>((event, emit) {
      emit(
        PreloadState(
          controllers: state.controllers,
          focusedIndex: state.focusedIndex,
          isReelsVisible: event.isReelsVisible,
        ),
      );
    });
  }

//====================Play Next Video====================//
  void _playNext(int index) {
    _stopControllerAtIndex(index - 1);

    _disposeControllerAtIndex(index - 2);

    _playControllerAtIndex(index);

    _initializeControllerAtIndex(index + 1);
  }

//====================Play Previous Video====================//
  void _playPrevious(int index) {
    _stopControllerAtIndex(index + 1);

    _disposeControllerAtIndex(index + 2);

    _playControllerAtIndex(index);

    _initializeControllerAtIndex(index - 1);
  }

//====================Initialize Controller on Given Index====================//
  Future<void> _initializeControllerAtIndex(int index) async {
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

//====================Play Video on Given Index====================//
  void _playControllerAtIndex(int index) {
    if (state.isReelsVisible) {
      if (state.urls.length > index && index >= 0) {
        /// Get controller at [index]
        final VideoPlayerController controller = state.controllers[index]!;

        /// Play controller
        controller.play();
      }
    }
  }

//====================Stop video on Given Index====================//
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

//====================Dispose Controller at Given Index====================//
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

//====================Pause Current Controller====================//
  void pauseCurrentController() {
    Future.delayed(Duration.zero, () {
      _stopControllerAtIndex(state.focusedIndex);
    });
  }

//====================Play Paused Controller====================//
  void playCurrentController() async {
    if (!state.controllers[state.focusedIndex]!.value.isPlaying) {
      Future.delayed(Duration.zero, () {
        _playControllerAtIndex(state.focusedIndex);
      });
    }
  }

//====================Dispose all Controllers====================//
  void disposeAllControllers() {
    state.controllers.forEach((key, value) {
      if (key >= 0) {
        value.dispose();
      }
    });
    state.controllers.clear();
  }

//====================State Change Logger====================//
  @override
  void onChange(Change<PreloadState> change) {
    log('CURRENT STATE : ${change.currentState}');
    log('NEXT STATE: ${change.nextState}');
    super.onChange(change);
  }
}

final preloadBloc = PreloadBloc();







//====================Initialize Controller on Given Index(Uses Cache)====================//
  // Future _initializeControllerAtIndex(int index) async {
  //   if (state.urls.length > index && index >= 0) {
  //     final VideoPlayerController? controller;
  //     final fileInfo =
  //         await DefaultCacheManager().getFileFromCache(state.urls[index]);

  //     if (fileInfo == null) {
  //       DefaultCacheManager().downloadFile(state.urls[index]);
  //       controller =
  //           VideoPlayerController.networkUrl(Uri.parse(state.urls[index]));
  //     } else {
  //       controller = VideoPlayerController.file(fileInfo.file);
  //     }

  //     // Create new controller

  //     // Add to [controllers] list
  //     state.controllers[index] = controller;

  //     // Initialize
  //     await controller.initialize();
  //   }
  // }