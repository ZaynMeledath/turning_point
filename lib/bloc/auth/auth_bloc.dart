import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/model/user_model.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/service/auth/auth_provider.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(InitialState()) {
//====================Initialize====================//
    on<AuthInitializeEvent>((event, emit) async {
      // await provider.initialize();
      // final user = provider.currentUser;
      UserModelResponse? user = UserRepository.getUserFromPreference();
      if (user == null) {
        emit(SignedOutState());
      }
      // else if (!user.isPhoneVerified) {
      //   emit(OtpVerificationNeededState());
      // }
      else {
        emit(SignedInState());
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
        emit(SignUpState(
          isContractor: event.isContractor,
          isLoading: false,
        ));
      },
    );

//====================SignUpEvent====================//
    on<SignUpEvent>(
      (event, emit) async {
        emit(
          SignUpState(
            isContractor: event.isContractor,
            isLoading: true,
          ),
        );
        try {
          final isSuccess =
              await UserRepository.userSignUp(mobileNumber: event.mobileNumber);
          if (isSuccess) {
            emit(OtpVerificationNeededState());
          }
        } catch (e) {
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

//====================SignInEvent====================//
    on<SignInEvent>(
      (event, emit) async {
        await UserRepository.getUserById();
        emit(SignedInState());
      },
    );
  }
}
