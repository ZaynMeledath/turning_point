part of 'rewards_bloc.dart';

@immutable
sealed class RewardsState {}

class RewardsLoadingState extends RewardsState {}

class RewardsLoadedState extends RewardsState {}
