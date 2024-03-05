part of 'rewards_bloc.dart';

@immutable
sealed class RewardsEvent {}

class RewardsLoadEvent extends RewardsEvent {}

class RewardsTabSwitchedEvent extends RewardsEvent {
  final int tabIndex;
  RewardsTabSwitchedEvent(this.tabIndex);
}

class RewardsScreenScrolledEvent extends RewardsEvent {
  final bool isScrolled;

  RewardsScreenScrolledEvent({required this.isScrolled});
}
