import 'dart:developer';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/bloc/contractor/contractor_bloc.dart';
import 'package:turning_point/bloc/reels/reels_bloc.dart';
import 'package:turning_point/constants/constants.dart';
import 'package:turning_point/exceptions/user_exceptions.dart';
import 'package:turning_point/model/contractor_model.dart';
import 'package:turning_point/model/user_model.dart';
import 'package:turning_point/resources/reels_repository.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/service/api/api_exception.dart';
import 'package:turning_point/service/auth/firebase_auth_provider.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final provider = FirebaseAuthProvider();
  ProfileBloc() : super(ProfileLoadingState()) {
//====================Profile Load Event====================//
    on<ProfileLoadEvent>((event, emit) async {
      try {
        final userModelResponse =
            await UserRepository.getUserById(avoidGettingFromPreference: false);

        if (userModelResponse != null && userModelResponse.data != null) {
          final isContractor = userModelResponse.data!.role == Role.CONTRACTOR;
          final reelsModelResponse = await ReelsRepository.getReels();
          reelsBloc.state.reelsModelList = reelsModelResponse.data;

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
        userModelResponse.data!.contractor = event.contractor;
        userModelResponse.data!.phone = event.phone;
        userModelResponse.data!.businessName = event.businessName;
        userModelResponse.data!.address = event.address;
        userModelResponse.data!.email = event.email;
        userModelResponse.data!.role =
            event.isContractor ? Role.CONTRACTOR : Role.CARPENTER;

        if (!event.isContractor &&
            (userModelResponse.data!.contractor?.name == null)) {
          userModelResponse.data!.contractor = DEFAULT_CONTRACTOR;
        }

        emit(ProfileLoadedState(
          isLoading: true,
          userModel: userModelResponse.data!,
          isContractor: event.isContractor,
        ));

        userModelResponse = await UserRepository.updateUserProfile(
          userModel: userModelResponse.data!,
        );
        contractorBloc.add(ContractorLoadEvent());
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
            isContractor: userModelResponse.data!.role == Role.CONTRACTOR,
          ),
        );
        final imageMap = await UserRepository.fetchImageFromStorage();

        if (imageMap != null) {
          userModelResponse = await UserRepository.updateProfileImage(
            imageMap.keys.elementAt(0),
          );
        }
        emit(
          ProfileLoadedState(
            isLoading: false,
            userModel: userModelResponse.data!,
            isContractor: userModelResponse.data!.role == Role.CONTRACTOR,
          ),
        );
      } catch (_) {
        log('EXEPTION IN BLOC');
        throw CouldNotUpdateUserProfileImageException();
      }
    });

//====================Profile Email Update Event====================//
    on<ProfileEmailUpdateEvent>((event, emit) async {
      try {
        final userModelResponse = UserRepository.getUserFromPreference()!;
        emit(
          ProfileLoadedState(
            isLoading: true,
            isContractor: userModelResponse.data!.role == Role.CONTRACTOR,
            userModel: userModelResponse.data!,
          ),
        );
        // await provider.signOut();
        final token = await provider.signIn();

        log('TOKEN : $token');

        userModelResponse.data!.email = provider.currentUser!.email;
        UserRepository.updateUserProfile(userModel: userModelResponse.data!);

        emit(
          ProfileLoadedState(
            isLoading: false,
            isContractor: userModelResponse.data!.role == Role.CONTRACTOR,
            userModel: userModelResponse.data!,
          ),
        );
      } catch (e) {
        throw Exception(e);
      }
    });

//====================Profile Phone Update Event====================//
    on<ProfilePhoneUpdateEvent>((event, emit) async {
      try {
        final userModelResponse = UserRepository.getUserFromPreference()!;
        emit(
          ProfileLoadedState(
            isLoading: true,
            isContractor: userModelResponse.data!.role == Role.CONTRACTOR,
            userModel: userModelResponse.data!,
          ),
        );
        await provider.signIn();
        await provider.sendPhoneVerification(phone: event.phone);
        emit(
          ProfileLoadedState(
            isLoading: true,
            isContractor: userModelResponse.data!.role == Role.CONTRACTOR,
            userModel: userModelResponse.data!,
            verifyOtp: true,
          ),
        );
      } catch (e) {
        throw Exception(e);
      }
    });

//====================Profile Phone Update Event====================//
    on<ProfileVerifyOtpEvent>((event, emit) async {
      await provider.verifyOtp(
        verificationId: FirebaseAuthProvider.verifyId,
        otp: event.otp,
      );
      final userModelResponse = UserRepository.getUserFromPreference()!;
      userModelResponse.data!.phone = event.phone;
      UserRepository.addUserToPreference(userModelResponse);
      UserRepository.updateUserProfile(userModel: userModelResponse.data!);
      emit(
        ProfileLoadedState(
          isLoading: false,
          userModel: userModelResponse.data!,
          isContractor: userModelResponse.data!.role == Role.CONTRACTOR,
        ),
      );
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
