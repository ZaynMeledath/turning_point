part of 'auth_bloc.dart';

sealed class AuthEvent {}

class AuthInitializeEvent extends AuthEvent {}

class GoogleSignInEvent extends AuthEvent {}

class WhoIsSigningEvent extends AuthEvent {
  final bool isContractor;
  WhoIsSigningEvent({required this.isContractor});
}

class SignUpEvent extends AuthEvent {
  final String mobileNumber;
  SignUpEvent({required this.mobileNumber});
}

class VerifyOtpEvent extends AuthEvent {}

class SignInEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}
