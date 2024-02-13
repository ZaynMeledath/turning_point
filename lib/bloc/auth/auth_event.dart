part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthInitializeEvent extends AuthEvent {}

class GoogleSignInEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {
  final String mobileNumber;
  final bool isContractor;
  SignUpEvent({
    required this.mobileNumber,
    required this.isContractor,
  });
}

class UpdateContractor extends AuthEvent {
  final String contractor;

  UpdateContractor({required this.contractor});
}

class VerifyOtpEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}
