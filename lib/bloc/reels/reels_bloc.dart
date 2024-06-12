import 'dart:developer';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/bloc/points/points_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/model/reels_model.dart';
import 'package:turning_point/resources/reels_repository.dart';
import 'package:turning_point/resources/user_repository.dart';

part 'reels_event.dart';
part 'reels_state.dart';

class ReelsBloc extends Bloc<ReelsEvent, ReelsState> {
  bool isDownloading = false;
  ReelsBloc() : super(ReelsLoadingState()) {
    final userModelResponse = UserRepository.getUserFromPreference();

//====================Reel Load Event====================//
    on<ReelLoadEvent>((event, emit) async {
      emit(
        ReelsLoadedState(
          reelsModelList: ReelsRepository.reelsModelResponse.data,
          isLikeButtonActive: false,
        ),
      );
    });

//====================Reel Like Event====================//
    on<ReelLikeEvent>((event, emit) async {
      final reelData =
          ReelsRepository.reelsModelResponse.data![event.reelIndex];

      if (reelData.isLiked != true) {
        reelData.isLiked = true;
        userModelResponse!.data!.points =
            userModelResponse.data!.points! + reelData.points!;

        profileBloc.state.userModel = userModelResponse.data!;

        UserRepository.addUserToPreference(userModelResponse);

        pointsBloc.add(PointsLoadEvent());

        emit(
          ReelsLoadedState(
            reelsModelList: ReelsRepository.reelsModelResponse.data,
            isLikeButtonActive: true,
          ),
        );
        await ReelsRepository.likeReel(event.reelIndex);
        pointsBloc.add(PointsLoadEvent(avoidGettingUserFromPreference: true));
      }
    });

//====================Reel Download Event====================//
    on<ReelDownloadEvent>((event, emit) async {
      try {
        isDownloading = true;
        emit(ReelsLoadedState(
          reelsModelList: state.reelsModelList,
          isLikeButtonActive: state.isLikeButtonActive,
        ));

        await ReelsRepository.downloadAndSaveVideo(
            state.reelsModelList![event.reelIndex].fileUrl!);

        isDownloading = false;
        return emit(
          ReelsLoadedState(
            reelsModelList: state.reelsModelList,
            isLikeButtonActive: state.isLikeButtonActive,
          ),
        );
      } catch (e) {
        ReelsRepository.cancelToken.cancel();
        isDownloading = false;
        return emit(
          ReelsLoadedState(
            reelsModelList: state.reelsModelList,
            isLikeButtonActive: state.isLikeButtonActive,
          ),
        );
      }
    });

    on<ReelLikeButtonEnableEvent>(((event, emit) {
      emit(ReelsLoadedState(
        reelsModelList: state.reelsModelList,
        isLikeButtonActive: true,
      ));
    }));
  }

//====================State Change Logger====================//
  @override
  void onChange(Change<ReelsState> change) {
    log('CURRENT STATE : ${change.currentState}');
    log('NEXT STATE: ${change.nextState}');
    super.onChange(change);
  }
}

final reelsBloc = ReelsBloc();
