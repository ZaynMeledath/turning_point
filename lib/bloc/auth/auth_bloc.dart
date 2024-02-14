import 'dart:developer';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
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
      await provider.initialize();
      // final user = provider.currentUser;
      UserModelResponse? user = UserRepository.getUserFromPreference();
      if (user == null) {
        return emit(InitialState());
      }
      // else if (!user.isPhoneVerified) {
      //   emit(OtpVerificationNeededState());
      // }
      else {
        return emit(SignedInState());
      }
    });

//====================GoogleSignInEvent====================//
    on<GoogleSignInEvent>(
      (event, emit) async {
        // try {
        // final token = await provider.signIn();
        // await UserRepository.userSignIn(token);

        await UserRepository.userSignUp(mobileNumber: '8140470004');

        emit(SignedInState());
        // emit(WhoIsSigningState());
        // } on UserAlreadyRegisteredAuthException {
        // await UserRepository.userSignUp(mobileNumber: '8140470004');
        //   emit(SignedInState());
        // }
      },
    );

//====================SignUpEvent====================//
    on<SignUpEvent>(
      (event, emit) async {
        emit(
          AuthLoadingState(),
        );
        try {
          final isSuccess =
              await UserRepository.userSignUp(mobileNumber: event.mobileNumber);
          if (isSuccess) {
            emit(OtpVerificationNeededState());
          }
        } catch (e) {
          log('EXCEPTION');
          //Exception
        }
      },
    );

//====================VerifyOtpEvent====================//
    on<VerifyOtpEvent>(
      (event, emit) async {
        emit(OtpVerifiedState());
      },
    );
  }
}

final authBloc = AuthBloc(FirebaseAuthProvider());
