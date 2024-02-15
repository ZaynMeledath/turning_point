part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthLoadingState extends AuthState {}

class InitialState extends AuthState {}

class SignInState extends AuthState {}

class WhoIsSigningState extends AuthState {}

class OtpVerificationNeededState extends AuthState {}

class OtpVerifiedState extends AuthState {}

class SignedInState extends AuthState {}
