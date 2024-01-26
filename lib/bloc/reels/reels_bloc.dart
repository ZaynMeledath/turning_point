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
        emit(ReelLikedState(userModel!));
        await ReelRepository.likeReel(event.reelIndex);
      }
    });
  }
}
