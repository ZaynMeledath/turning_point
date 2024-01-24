import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/resources/reel_repository.dart';

part 'reels_event.dart';
part 'reels_state.dart';

class ReelsBloc extends Bloc<ReelsEvent, ReelsState> {
  ReelsBloc() : super(InitialReelState()) {
    on<ReelLoadEvent>((event, emit) async {
      final reelMap = await ReelRepository.reelsStreamController.stream
          .elementAt(event.reelIndex);
      if (reelMap['isLiked'] == true) {
        emit(ReelLikedState());
      } else {
        emit(InitialReelState());
      }
    });

    on<ReelLikeEvent>((event, emit) async {
      emit(ReelLikedState());
      await ReelRepository.likeReel(event.reelIndex);
    });
  }
}
