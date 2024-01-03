part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class InitialState extends AuthState {}

class SignInState extends AuthState {}

class WhoIsSigningState extends AuthState {}

class SignUpState extends AuthState {
  final bool isContractor;
  SignUpState({required this.isContractor});
}

class OtpVerificationNeededState extends AuthState {}

class OtpVerifiedState extends AuthState {}

class SignedInState extends AuthState {
  final UserModel user;

  SignedInState({required this.user});
}

class SignedOutState extends AuthState {}
