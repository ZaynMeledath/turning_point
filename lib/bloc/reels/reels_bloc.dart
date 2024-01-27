import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/model/user_model.dart';
import 'package:turning_point/resources/reel_repository.dart';
import 'package:turning_point/resources/user_repository.dart';

part 'reels_event.dart';
part 'reels_state.dart';

class ReelsBloc extends Bloc<ReelsEvent, ReelsState> {
  final userModel = UserRepository.getUserFromPreference();
  ReelsBloc()
      : super(InitialReelState(UserRepository.getUserFromPreference())) {
    on<ReelLoadEvent>((event, emit) async {
      final reelData = ReelRepository.reelsModel.data![event.reelIndex];
      if (reelData.isLiked == true) {
        return emit(ReelLikedState(userModel!));
      } else {
        emit(InitialReelState(userModel));
        await Future.delayed(Duration(seconds: reelData.displayLikeAfter!));
        return emit(LikeButtonActiveState(userModel));
      }
    });

    on<ReelLikeEvent>((event, emit) async {
      final reelData = ReelRepository.reelsModel.data![event.reelIndex];

      if (reelData.isLiked != true) {
        reelData.isLiked = true;
        userModel!.data!.points = userModel!.data!.points! + reelData.points!;

        //To ensure only the fileName is added to the userModel because the rest of the url will be appended from json to UserModel conversion
        userModel!.data!.image = userModel!.data!.image!.split('/').last;
        UserRepository.addUserToPreference(userModel!);
        emit(ReelLikedState(userModel!));
        await ReelRepository.likeReel(event.reelIndex);
      }
    });
  }
}
