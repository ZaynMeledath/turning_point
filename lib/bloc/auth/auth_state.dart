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
  final UserModel? contractors;
  SignUpState({
    required this.isContractor,
    required this.isLoading,
    this.contractors,
  });
}

class OtpVerificationNeededState extends AuthState {}

class SignedInState extends AuthState {}

class SignedOutState extends AuthState {}
