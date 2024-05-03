part of 'referral_bloc.dart';

@immutable
sealed class ReferralState {
  final ReferralModel? referralModel;

  const ReferralState({required this.referralModel});
}

class ReferralLoadingState extends ReferralState {
  const ReferralLoadingState({required super.referralModel});
}

class ReferralLoadedState extends ReferralState {
  const ReferralLoadedState({required super.referralModel});
}

class ReferralErrorState extends ReferralState {
  const ReferralErrorState({required super.referralModel});
}
