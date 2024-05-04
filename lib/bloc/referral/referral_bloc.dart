import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/model/referral_model.dart';
import 'package:turning_point/resources/user_repository.dart';

part 'referral_event.dart';
part 'referral_state.dart';

class ReferralBloc extends Bloc<ReferralEvent, ReferralState> {
  ReferralBloc() : super(const ReferralLoadingState(referralModel: null)) {
//====================Referral Load Event====================//
    on<ReferralLoadEvent>((event, emit) async {
      final referralModelResponse = await UserRepository.getReferralReport();
      if (referralModelResponse != null && referralModelResponse.data != null) {
        return emit(
            ReferralLoadedState(referralModel: referralModelResponse.data!));
      } else {
        return emit(const ReferralErrorState(referralModel: null));
      }
    });

//====================Referral Load Event====================//
    on<ReferralRewardScratchedEvent>((event, emit) async {
      final referralModel = state.referralModel;
      //Insert the applied reward to Applied Rewards
      referralModel!.appliedRewards!
          .insert(0, referralModel.pendingRewards![event.rewardIndex]);

      //Remove the applied Reward from Pending Rewards
      referralModel.pendingRewards!.removeAt(event.rewardIndex);
      emit(ReferralLoadedState(referralModel: referralModel));

      //Apply the Reward
      await UserRepository.applyReferralReward(
          rewardId: referralModel.pendingRewards![event.rewardIndex].id!);
      final referralModelResponse = await UserRepository.getReferralReport();

      if (referralModelResponse != null && referralModelResponse.data != null) {
        profileBloc.add(ProfileLoadEvent(avoidGettingFromPreference: true));
        return emit(
            ReferralLoadedState(referralModel: referralModelResponse.data!));
      } else {
        return emit(const ReferralErrorState(referralModel: null));
      }
    });
  }
}

final referralBloc = ReferralBloc();
