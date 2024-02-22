import 'dart:developer';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/exceptions/user_exceptions.dart';
import 'package:turning_point/model/contractor_model.dart';
import 'package:turning_point/model/user_model.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/service/api/api_exception.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileLoadingState()) {
//====================Profile Load Event====================//
    on<ProfileLoadEvent>((event, emit) async {
      try {
        final userModelResponse =
            await UserRepository.getUserById(avoidGettingFromPreference: false);

        if (userModelResponse != null && userModelResponse.data != null) {
          final isContractor = userModelResponse.data!.role == 'CONTRACTOR';

          return emit(ProfileLoadedState(
            isLoading: false,
            userModel: userModelResponse.data!,
            isContractor: isContractor,
          ));
        } else {
          return emit(ProfileLoadErrorState());
        }
      } on ProfileInactiveException {
        log('EMITTING PROFILE INACTIVE STATE');
        // return emit(ProfileInactiveState());
      }
    });

//====================Profile Update Event====================//
    on<ProfileUpdateEvent>((event, emit) async {
      try {
        UserModelResponse? userModelResponse =
            UserRepository.getUserFromPreference();

        userModelResponse!.data!.name = event.name;
        userModelResponse.data!.phone = event.phone;
        userModelResponse.data!.businessName = event.businessName;
        userModelResponse.data!.address = event.address;
        userModelResponse.data!.email = event.email;
        userModelResponse.data!.contractor = event.contractor;

        emit(ProfileLoadedState(
          isLoading: true,
          userModel: userModelResponse.data!,
          isContractor: event.isContractor,
        ));

        userModelResponse = await UserRepository.updateUserProfile(
          userModel: userModelResponse.data!,
        );

        emit(ProfileLoadedState(
          isLoading: false,
          userModel: userModelResponse.data!,
          isContractor: event.isContractor,
        ));
      } catch (_) {}
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

//====================Profile Picture Update Event====================//
    on<ProfilePictureUpdateEvent>((event, emit) async {
      try {
        UserModelResponse? userModelResponse =
            UserRepository.getUserFromPreference();
        emit(
          ProfileLoadedState(
            isLoading: true,
            userModel: userModelResponse!.data!,
            isContractor: userModelResponse.data!.role == 'CONTRACTOR',
          ),
        );
        final imageString = await UserRepository.fetchImageFromStorage();

        if (imageString != null) {
          userModelResponse =
              await UserRepository.updateProfileImage(imageString);
        }
        emit(
          ProfileLoadedState(
            isLoading: false,
            userModel: userModelResponse.data!,
            isContractor: userModelResponse.data!.role == 'CONTRACTOR',
          ),
        );
      } catch (_) {
        log('EXEPTION IN BLOC');
        throw CouldNotUpdateUserProfileImageException();
      }
    });
  }

//====================State Change Logger====================//
  @override
  void onChange(Change<ProfileState> change) {
    log('CURRENT STATE : ${change.currentState}');
    log('NEXT STATE: ${change.nextState}');
    super.onChange(change);
  }
}

final profileBloc = ProfileBloc();
