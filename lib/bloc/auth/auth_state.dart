part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthLoading extends AuthState {}

class InitialState extends AuthState {}

class SignInState extends AuthState {}

class WhoIsSigningState extends AuthState {}

class SignUpState extends AuthState {
  final bool isContractor;
  final bool isLoading;
  SignUpState({
    required this.isContractor,
    required this.isLoading,
  });
}

class OtpVerificationNeededState extends AuthState {}

class OtpVerifiedState extends AuthState {}

class SignedInState extends AuthState {
  SignedInState();
}

class SignedOutState extends AuthState {}
