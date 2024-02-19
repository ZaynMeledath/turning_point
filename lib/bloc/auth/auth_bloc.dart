import 'dart:developer';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/model/contractor_model.dart';
import 'package:turning_point/model/user_model.dart';
import 'package:turning_point/resources/user_repository.dart';
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
        UserModelResponse? user = UserRepository.getUserFromPreference();
        if (user == null) {
          if (provider.currentUser != null) {
            provider.signOut();
          }
          return emit(InitialState());
        } else {
          return emit(SignedInState());
        }
      } catch (e) {
        log('EXCEPTION IN AuthInitializeEvent : $e');
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
            emit(SignedInState());
          } else {
            emit(WhoIsSigningState());
          }
        } catch (e) {
          log('EXCEPTION IN GOOGLE SIGN IN : $e');
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
          emit(
            OtpVerificationNeededState(
              phone: event.phone,
              businessName: event.businessName,
              contractor: event.contractor,
            ),
          );
          await provider.sendPhoneVerification(phone: event.phone);
        } catch (e) {
          log('EXCEPTION IN SIGNUP EVENT : $e');
        }
      },
    );

//====================VerifyOtpEvent====================//
    on<VerifyOtpEvent>(
      (event, emit) async {
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

          log('PHONE NUMBER FROM VERIFY OTP EVENT: ${state.phone}');
          await UserRepository.userSignUp(
            phone: state.phone!,
            businessName: state.businessName,
            contractor: state.contractor,
            token: token,
          );

          emit(OtpVerifiedState());
        } catch (e) {
          log('EXCEPTION IN VERIFY OTP EVENT: $e');
        }
      },
    );
  }
  @override
  void onChange(Change<AuthState> change) {
    log('CURRENT STATE : ${change.currentState}');
    log('NEXT STATE: ${change.nextState}');
    super.onChange(change);
  }
}

final authBloc = AuthBloc(FirebaseAuthProvider());
