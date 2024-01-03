part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class InitialState extends AuthState {}

class SignInState extends AuthState {}

class WhoIsSigningState extends AuthState {}

class SignUpState extends AuthState {}

class OtpVerificationNeededState extends AuthState {}

class SignedInState extends AuthState {
  final UserModel user;

  SignedInState({required this.user});
}

class SignedOutState extends AuthState {}
