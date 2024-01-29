import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/model/user_model.dart';
import 'package:turning_point/resources/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileLoadingState()) {
//====================Profile Load Event====================//
    on<ProfileLoadEvent>((event, emit) {
      final userModelResponse = UserRepository.getUserFromPreference();

      if (userModelResponse != null && userModelResponse.data != null) {
        final isContractor = userModelResponse.data!.role == 'CONTRACTOR';
        emit(ProfileLoadedState(
          isLoading: false,
          userModel: userModelResponse.data!,
          isContractor: isContractor,
        ));
      } else {
        emit(ProfileLoadErrorState());
      }
    });

//====================Profile Update Event====================//
    on<ProfileUpdateEvent>((event, emit) async {
      UserModelResponse? userModelResponse =
          UserRepository.getUserFromPreference();
      final isContractor = userModelResponse!.data!.role == 'CONTRACTOR';
      emit(ProfileLoadedState(
          isLoading: true,
          userModel: userModelResponse.data!,
          isContractor: isContractor));
      userModelResponse = await UserRepository.updateUserProfile(
        name: event.name,
        phone: event.phone,
        businessName: event.businessName,
        email: event.email,
      );

      emit(ProfileLoadedState(
        isLoading: false,
        userModel: userModelResponse!.data!,
        isContractor: isContractor,
      ));
    });

//====================Profile Radio Trigger Event====================//
    on<ProfileRadioTriggerEvent>((event, emit) {
      UserModelResponse? userModelResponse =
          UserRepository.getUserFromPreference();
      emit(ProfileLoadedState(
        isLoading: false,
        userModel: userModelResponse!.data!,
        isContractor: event.isContractor,
      ));
    });
  }
}
