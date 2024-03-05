part of 'rewards_bloc.dart';

sealed class RewardsState {
  RewardsModel? currentRewardsModel;
  RewardsModel? previousRewardsModel;
  int tabIndex = 0;
  bool? isScrolled = false;

  RewardsState({
    required this.currentRewardsModel,
    required this.previousRewardsModel,
    required this.tabIndex,
    this.isScrolled,
  });
}

class RewardsLoadingState extends RewardsState {
  RewardsLoadingState()
      : super(
          currentRewardsModel: null,
          previousRewardsModel: null,
          tabIndex: 0,
        );
}

class RewardsLoadedState extends RewardsState {
  RewardsLoadedState({
    required super.currentRewardsModel,
    required super.previousRewardsModel,
    required super.tabIndex,
    super.isScrolled,
  });
}

// class RewardsErrorState extends RewardsState {}
