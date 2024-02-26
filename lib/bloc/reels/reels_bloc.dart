import 'dart:developer';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/model/reels_model.dart';
import 'package:turning_point/resources/reels_repository.dart';
import 'package:turning_point/resources/user_repository.dart';

part 'reels_event.dart';
part 'reels_state.dart';

class ReelsBloc extends Bloc<ReelsEvent, ReelsState> {
  ReelsBloc() : super(ReelsLoadingState()) {
    final userModelResponse = UserRepository.getUserFromPreference();
    on<ReelLoadEvent>((event, emit) async {
      final reelData =
          ReelsRepository.reelsModelResponse.data![event.reelIndex];

      reelData.isLikeButtonActive = false;

      emit(
        ReelsLoadedState(
          userPoints: userModelResponse!.data!.points,
          reelsModelList: ReelsRepository.reelsModelResponse.data,
        ),
      );
      await Future.delayed(Duration(seconds: reelData.displayLikeAfter ?? 10));
      ReelsRepository
          .reelsModelResponse.data![event.reelIndex].isLikeButtonActive = true;
      return emit(
        ReelsLoadedState(
          userPoints: userModelResponse.data!.points,
          reelsModelList: ReelsRepository.reelsModelResponse.data,
        ),
      );
    });

    on<ReelLikeEvent>((event, emit) async {
      final reelData =
          ReelsRepository.reelsModelResponse.data![event.reelIndex];

      if (reelData.isLiked != true) {
        reelData.isLiked = true;
        userModelResponse!.data!.points =
            userModelResponse.data!.points! + reelData.points!;

        profileBloc.state.userModel = userModelResponse.data!;

        UserRepository.addUserToPreference(userModelResponse);

        emit(
          ReelsLoadedState(
            userPoints: userModelResponse.data!.points,
            reelsModelList: ReelsRepository.reelsModelResponse.data,
          ),
        );
        await ReelsRepository.likeReel(event.reelIndex);
      }
    });
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
