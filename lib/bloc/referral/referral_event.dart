part of 'referral_bloc.dart';

@immutable
sealed class ReferralEvent {}

class ReferralLoadEvent extends ReferralEvent {}

class ReferralRewardScratchedEvent extends ReferralEvent {
  final int rewardIndex;
  ReferralRewardScratchedEvent(this.rewardIndex);
}
