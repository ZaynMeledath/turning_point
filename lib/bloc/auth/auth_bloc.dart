import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show TextEditingController, immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:turning_point/bloc/points/points_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/model/contractor_model.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/service/Exception/api_exception.dart';
import 'package:turning_point/service/auth/auth_exceptions.dart';
import 'package:turning_point/service/auth/auth_provider.dart';
import 'package:turning_point/service/auth/firebase_auth_provider.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(CustomAuthProvider provider) : super(InitialState()) {
//====================Initialize====================//
    on<AuthInitializeEvent>((event, emit) async {
      try {
        emit(const AuthLoadingState());
        await provider.initialize();
        final userFromPreference = UserRepository.getUserFromPreference();
        if (provider.currentUser == null && userFromPreference != null) {
          // AppPreferences.clearSharedPreferences();
          // return emit(InitialState());
          await provider.signIn();
        }
        final user =
            await UserRepository.getUserById(avoidGettingFromPreference: true);
        if (user == null) {
          // if (provider.currentUser != null) provider.signOut();
          final token = await provider.signIn();
          final fcmToken = await provider.getFcmToken();
          await UserRepository.userSignIn(
            token: token,
            fcmToken: fcmToken!,
          );
        }
        // AppPreferences.clearSharedPreferences();
        // return emit(InitialState());
        profileBloc.add(ProfileLoadEvent(avoidGettingFromPreference: true));
        pointsBloc.add(PointsLoadEvent(avoidGettingUserFromPreference: true));
        return emit(SignedInState());
      } on ProfileInactiveException {
        return emit(ProfileInactiveState());
      } catch (e) {
        return emit(InitialState());
      }
    });

//====================GoogleSignInEvent====================//
    on<GoogleSignInEvent>(
      (event, emit) async {
        emit(const AuthLoadingState());
        try {
          final token = await provider.signIn();
          final fcmToken = await provider.getFcmToken();
          final status = await UserRepository.userSignIn(
            token: token,
            fcmToken: fcmToken!,
          );
          if (status) {
            await UserRepository.getUserById(avoidGettingFromPreference: true);
            profileBloc.add(ProfileLoadEvent(avoidGettingFromPreference: true));
            pointsBloc
                .add(PointsLoadEvent(avoidGettingUserFromPreference: true));
            return emit(SignedInState());
          } else {
            return emit(WhoIsSigningState());
          }
        } on ProfileInactiveException {
          return emit(ProfileInactiveState());
        } on CouldNotSignInUserAuthException catch (e) {
          return emit(AuthErrorState(message: e.errorMessage));
        } catch (e) {
          throw Exception(e);
        }
      },
    );

//====================Sign Up Event====================//
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
                refCode: event.refCode,
              ),
            );
            await provider.sendPhoneVerification(
              phone: event.phone,
              otpController: event.otpController,
            );
          }
        } on FirebaseAuthException catch (e) {
          emit(SignUpState(exception: e));
        } catch (e) {
          throw Exception(e);
        }
      },
    );

//====================Verify Otp Event====================//
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
            location: event.location,
            refCode: state.refCode,
          );
        } else {
          emit(
            const AuthErrorState(message: 'Error Signing Up. Please try again'),
          );
        }

        emit(OtpVerifiedState());
      } on FirebaseAuthException catch (e) {
        return emit(
          OtpVerificationNeededState(
            phone: state.phone,
            businessName: state.businessName,
            contractor: state.contractor,
            exception: e.code,
            refCode: state.refCode,
          ),
        );
      } catch (e) {
        return emit(
          OtpVerificationNeededState(
            phone: state.phone,
            businessName: state.businessName,
            contractor: state.contractor,
            exception: Exception(e),
            refCode: state.refCode,
          ),
        );
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

//====================Sign Out Event====================//
    on<SignOutEvent>((event, emit) async {
      try {
        await provider.signOut();
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
