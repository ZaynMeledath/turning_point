import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:turning_point/model/rewards_model.dart';
import 'package:turning_point/resources/contest_repository.dart';
import 'package:turning_point/service/Exception/api_exception.dart';

part 'rewards_event.dart';
part 'rewards_state.dart';

class RewardsBloc extends Bloc<RewardsEvent, RewardsState> {
  RewardsBloc() : super(RewardsLoadingState()) {
    on<RewardsLoadEvent>((event, emit) async {
      try {
        final currentRewardsModelResponse =
            await ContestRepository.getCurrentRewards();
        state.currentRewardsModel = currentRewardsModelResponse.data!;
        final previousRewardsModelResponse =
            await ContestRepository.getPreviousRewards();
        state.previousRewardsModel = previousRewardsModelResponse.data!;

        return emit(
          RewardsLoadedState(
            currentRewardsModel: state.currentRewardsModel,
            previousRewardsModel: state.previousRewardsModel,
          ),
        );
      } on NotFoundException {
        // if (e.message == 'No previous closed contest found') {
        //   final currentRewardsModelResponse =
        //       await ContestRepository.getCurrentRewards();
        //   final currentRewardsModel = currentRewardsModelResponse.data!;
        return emit(
          RewardsLoadedState(
            currentRewardsModel: state.currentRewardsModel,
            previousRewardsModel: state.previousRewardsModel,
          ),
        );
        // } else {
        //   return emit(
        //     const RewardsLoadedState(
        //       currentRewardsModel: null,
        //       previousRewardsModel: null,
        //     ),
        //   );
        // }
      }
    });
  }
}

final rewardsBloc = RewardsBloc();
