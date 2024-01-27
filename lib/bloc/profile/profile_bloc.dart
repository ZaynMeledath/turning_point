import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/model/user_model.dart';
import 'package:turning_point/resources/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileLoadingState()) {
//====================ProfileLoadEvent====================//
    on<ProfileLoadEvent>((event, emit) {
      final userModelResponse = UserRepository.getUserFromPreference();
      if (userModelResponse != null && userModelResponse.data != null) {
        emit(ProfileLoadedState(userModel: userModelResponse.data!));
      } else {
        emit(ProfileLoadErrorState());
      }
    });

//====================ProfileLoadEvent====================//
    on<ProfileUpdateEvent>((event, emit) async {
      final userModelResponse = await UserRepository.updateUserProfile(
        name: event.name,
        phone: event.phone,
        businessName: event.businessName,
        email: event.email,
      );
      emit(ProfileLoadedState(userModel: userModelResponse!.data!));
    });
  }
}
