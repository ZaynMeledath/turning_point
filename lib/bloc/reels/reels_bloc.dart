import 'dart:developer';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/resources/reel_repository.dart';
import 'package:turning_point/resources/user_repository.dart';

part 'reels_event.dart';
part 'reels_state.dart';

class ReelsBloc extends Bloc<ReelsEvent, ReelsState> {
  final userModel = UserRepository.getUserFromPreference();
  ReelsBloc() : super(InitialReelState()) {
    on<ReelLoadEvent>((event, emit) async {
      final reelData = ReelRepository.reelsModelResponse.data![event.reelIndex];

      if (reelData.isLiked == true) {
        return emit(ReelLikedState());
      } else {
        emit(InitialReelState());
        await Future.delayed(Duration(seconds: reelData.displayLikeAfter!));
        return emit(LikeButtonActiveState());
      }
    });

    on<ReelLikeEvent>((event, emit) async {
      final reelData = ReelRepository.reelsModelResponse.data![event.reelIndex];

      if (reelData.isLiked != true) {
        reelData.isLiked = true;
        userModel!.data!.points = userModel!.data!.points! + reelData.points!;

        //To ensure only the fileName is added to the userModel because the rest of the url will be appended from json to UserModel conversion
        // userModel!.data!.image = userModel!.data!.image!.split('/').last;

        UserRepository.addUserToPreference(userModel!);

        emit(ReelLikedState());
        await ReelRepository.likeReel(event.reelIndex);
      }
    });
  }
  @override
  void onChange(Change<ReelsState> change) {
    log('CURRENT STATE : ${change.currentState}');
    log('NEXT STATE: ${change.nextState}');
    super.onChange(change);
  }
}

final reelsBloc = ReelsBloc();
