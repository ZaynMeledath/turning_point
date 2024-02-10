import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/exceptions/user_exceptions.dart';
import 'package:turning_point/model/user_model.dart';
import 'package:turning_point/resources/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileLoadingState()) {
//====================Profile Load Event====================//
    on<ProfileLoadEvent>((event, emit) async {
      final userModelResponse = await UserRepository.getUserById();
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
      try {
        UserModelResponse? userModelResponse =
            UserRepository.getUserFromPreference();

        emit(ProfileLoadedState(
          isLoading: true,
          userModel: userModelResponse!.data!,
          isContractor: event.isContractor,
        ));

        userModelResponse.data!.name = event.name;
        userModelResponse.data!.phone = event.phone;
        userModelResponse.data!.shopName = event.businessName;
        userModelResponse.data!.email = event.email;

        userModelResponse = await UserRepository.updateUserProfile(
          userModel: userModelResponse.data!,
          isKyc: false,
        );

        emit(ProfileLoadedState(
          isLoading: false,
          userModel: userModelResponse!.data!,
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
          await UserRepository.updateProfileImage(imageString);
          userModelResponse = await UserRepository.getUserById();
        }
        emit(
          ProfileLoadedState(
            isLoading: false,
            userModel: userModelResponse!.data!,
            isContractor: userModelResponse.data!.role == 'CONTRACTOR',
          ),
        );
      } catch (_) {
        throw CouldNotUpdateUserProfileImageException();
      }
    });
  }
}
