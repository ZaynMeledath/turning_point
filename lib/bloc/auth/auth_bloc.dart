import 'dart:developer';

import 'package:flutter/material.dart' show TextEditingController, immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/model/contractor_model.dart';
import 'package:turning_point/preferences/app_preferences.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/service/Exception/api_exception.dart';
import 'package:turning_point/service/auth/auth_provider.dart';
import 'package:turning_point/service/auth/firebase_auth_provider.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(CustomAuthProvider provider) : super(InitialState()) {
//====================Initialize====================//
    on<AuthInitializeEvent>((event, emit) async {
      try {
        await provider.initialize();
        if (provider.currentUser == null) {
          AppPreferences.clearSharedPreferences();
          return emit(InitialState());
        }
        final user =
            await UserRepository.getUserById(avoidGettingFromPreference: true);
        if (user == null) {
          if (provider.currentUser != null) provider.signOut();

          AppPreferences.clearSharedPreferences();
          return emit(InitialState());
        } else {
          return emit(SignedInState());
        }
      } on ProfileInactiveException {
        return emit(ProfileInactiveState());
      } catch (e) {
        throw Exception(e);
      }
    });

//====================GoogleSignInEvent====================//
    on<GoogleSignInEvent>(
      (event, emit) async {
        emit(const AuthLoadingState());
        try {
          final token = await provider.signIn();
          final status = await UserRepository.userSignIn(token);
          if (status) {
            await UserRepository.getUserById(avoidGettingFromPreference: true);
            return emit(SignedInState());
          } else {
            return emit(WhoIsSigningState());
          }
        } on ProfileInactiveException {
          return emit(ProfileInactiveState());
        } catch (e) {
          throw Exception(e);
        }
      },
    );

//====================SignUpEvent====================//
    on<SignUpEvent>(
      (event, emit) async {
        emit(
          const AuthLoadingState(),
        );
        try {
          final phoneExists =
              await UserRepository.checkPhoneNumber(event.phone);

          if (phoneExists) {
            return emit(PhoneNumberExistsState());
          } else {
            emit(
              OtpVerificationNeededState(
                phone: event.phone,
                businessName: event.businessName,
                contractor: event.contractor,
              ),
            );
            await provider.sendPhoneVerification(
              phone: event.phone,
              otpController: event.otpController,
            );
          }
        } catch (e) {
          throw Exception(e);
        }
      },
    );

//====================VerifyOtpEvent====================//
    on<VerifyOtpEvent>((event, emit) async {
      emit(
        AuthLoadingState(
          phone: state.phone,
          businessName: state.businessName,
          contractor: state.contractor,
        ),
      );
      try {
        final token = await provider.verifyOtp(
          verificationId: FirebaseAuthProvider.verifyId,
          otp: event.otp,
        );

        final firebaseMessagingToken = await provider.getFcmToken();

        if (token != null && firebaseMessagingToken != null) {
          await UserRepository.userSignUp(
            phone: state.phone!,
            businessName: state.businessName,
            contractor: state.contractor,
            token: token,
            fcmToken: firebaseMessagingToken,
          );
        } else {
          emit(
            const AuthErrorState(message: 'Error Signing Up. Please try again'),
          );
        }

        emit(OtpVerifiedState());
      } catch (e) {
        throw Exception(e);
      }
    });

//====================Resend OTP Event====================//
    on<ResendOtpEvent>((event, emit) async {
      try {
        await provider.sendPhoneVerification(
          phone: event.phone,
          otpController: event.otpController,
        );
      } catch (e) {
        log('EXCEPTION IN RESEND OTP EVENT : $e');
      }
    });
  }

//====================State Change Logger====================//
  @override
  void onChange(Change<AuthState> change) {
    log('CURRENT STATE : ${change.currentState}');
    log('NEXT STATE: ${change.nextState}');
    super.onChange(change);
  }
}

final authBloc = AuthBloc(FirebaseAuthProvider());
