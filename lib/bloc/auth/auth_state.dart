part of 'auth_bloc.dart';

sealed class AuthState {}

class AuthLoading extends AuthState {}

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
  SignedInState();
}

class SignedOutState extends AuthState {}
