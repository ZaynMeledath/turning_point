import 'dart:developer';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/auth/auth_provider.dart';
import 'package:turning_point/model/user_model.dart';
import 'package:turning_point/preferences/app_preferences.dart';
import 'package:turning_point/service/api/api_endpoints.dart';
import 'package:turning_point/service/api/api_service.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(InitialState()) {
//====================Initialize====================//
    on<AuthInitializeEvent>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(SignedOutState());
      }
      // else if (!user.isPhoneVerified) {
      //   emit(OtpVerificationNeededState());
      // }
      else {
        emit(SignedInState(user: user));
      }
    });

//====================GoogleSignInEvent====================//
    on<GoogleSignInEvent>(
      (event, emit) async {
        try {
          // await provider.signIn();
          emit(WhoIsSigningState());
        } catch (e) {
          //Exception Handling
        }
      },
    );

//====================WhoIsSigningEvent====================//
    on<WhoIsSigningEvent>(
      (event, emit) {
        emit(SignUpState(isContractor: event.isContractor));
      },
    );

//====================SignUpEvent====================//
    on<SignUpEvent>(
      (event, emit) async {
        try {
          final decodedResponse = await ApiService().sendRequest(
            url: ApiEndpoints.login,
            data: {"phone": event.mobileNumber},
            requestMethod: 'POST',
            isTokenRequired: false,
          );

          log('JSON DECODED : $decodedResponse');

          await AppPreferences.init();
          AppPreferences.addSharedPreference(
            key: 'auth_token',
            value: decodedResponse["token"],
          );
          if (decodedResponse['success']) {
            emit(OtpVerificationNeededState());
          }
        } catch (e) {
          //Exception
        }
      },
    );

//====================VerifyOtpEvent====================//
    on<VerifyOtpEvent>(
      (event, emit) {
        emit(OtpVerifiedState());
      },
    );
  }
}
