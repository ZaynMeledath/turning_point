import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:turning_point/bloc/lucky_draw/lucky_draw_bloc.dart';
import 'package:turning_point/constants/constants.dart';
import 'package:turning_point/model/rewards_model.dart';
import 'package:turning_point/resources/contest_repository.dart';
import 'package:turning_point/service/Exception/api_exception.dart';

part 'rewards_event.dart';
part 'rewards_state.dart';

class RewardsBloc extends Bloc<RewardsEvent, RewardsState> {
  RewardsBloc() : super(RewardsLoadingState()) {
//====================Rewards Load Event====================//
    on<RewardsLoadEvent>((event, emit) async {
      try {
        if (luckyDrawBloc.state.secondsLeft == null ||
            luckyDrawBloc.state.secondsLeft! >
                luckyDrawBloc.state.contestModel!.prizeArr!.length *
                    LUCKY_DRAW_WINNER_DISPLAY_DELAY) {
          final currentRewardsModelResponse =
              await ContestRepository.getCurrentRewards();
          state.currentRewardsModel = currentRewardsModelResponse.data!;
        }
        final previousRewardsModelResponse =
            await ContestRepository.getPreviousRewards();
        state.previousRewardsModel = previousRewardsModelResponse.data!;

        return emit(
          RewardsLoadedState(
            currentRewardsModel: state.currentRewardsModel,
            previousRewardsModel: state.previousRewardsModel,
            tabIndex: state.tabIndex,
          ),
        );
      } on NotFoundException {
        // if (luckyDrawBloc.state.secondsLeft != null) {
        //   return emit(
        //     RewardsLoadedState(
        //       currentRewardsModel: null,
        //       previousRewardsModel: null,
        //       tabIndex: state.tabIndex,
        //     ),
        //   );
        // }
        return emit(
          RewardsLoadedState(
            currentRewardsModel: state.currentRewardsModel,
            previousRewardsModel: state.previousRewardsModel,
            tabIndex: state.tabIndex,
          ),
        );
      } catch (e) {
        return emit(
          RewardsLoadedState(
            currentRewardsModel: null,
            previousRewardsModel: null,
            tabIndex: state.tabIndex,
          ),
        );
      }
    });

//====================Rewards Tab Switched Event====================//
    on<RewardsTabSwitchedEvent>((event, emit) {
      emit(
        RewardsLoadedState(
          currentRewardsModel: state.currentRewardsModel,
          previousRewardsModel: state.previousRewardsModel,
          tabIndex: event.tabIndex,
        ),
      );
    });

//====================Rewards Screen Scrolled Event====================//
    on<RewardsScreenScrolledEvent>((event, emit) {
      emit(
        RewardsLoadedState(
          currentRewardsModel: state.currentRewardsModel,
          previousRewardsModel: state.previousRewardsModel,
          tabIndex: state.tabIndex,
          isScrolled: event.isScrolled,
        ),
      );
    });
  }
}

final rewardsBloc = RewardsBloc();
