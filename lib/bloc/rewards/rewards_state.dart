part of 'rewards_bloc.dart';

sealed class RewardsState {
  RewardsModel? currentRewardsModel;
  RewardsModel? previousRewardsModel;
  int tabIndex = 0;

  RewardsState({
    required this.currentRewardsModel,
    required this.previousRewardsModel,
  });
}

class RewardsLoadingState extends RewardsState {
  RewardsLoadingState()
      : super(currentRewardsModel: null, previousRewardsModel: null);
}

class RewardsLoadedState extends RewardsState {
  RewardsLoadedState({
    required super.currentRewardsModel,
    required super.previousRewardsModel,
  });
}

// class RewardsErrorState extends RewardsState {}
