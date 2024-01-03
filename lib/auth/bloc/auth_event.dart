part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthInitializeEvent extends AuthEvent {}

class GoogleSignInEvent extends AuthEvent {}

class WhoIsSigningEvent extends AuthEvent {
  final bool isContractor;
  WhoIsSigningEvent({required this.isContractor});
}

class SignUpEvent extends AuthEvent {}

class VerifyOtpEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}
