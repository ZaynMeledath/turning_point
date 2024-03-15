part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  final String? phone;
  final String? businessName;
  final ContractorModel? contractor;

  const AuthState({
    this.phone,
    this.businessName,
    this.contractor,
  });
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState({
    super.phone,
    super.businessName,
    super.contractor,
  });
}

class InitialState extends AuthState {}

class SignInState extends AuthState {}

class WhoIsSigningState extends AuthState {}

class OtpVerificationNeededState extends AuthState {
  final Exception? exception;
  const OtpVerificationNeededState({
    required super.phone,
    required super.businessName,
    required super.contractor,
    this.exception,
  });
}

class OtpVerifiedState extends AuthState {}

class SignedInState extends AuthState {}

class SignUpState extends AuthState {
  final Exception? exception;

  const SignUpState({
    this.exception,
  });
}

class PhoneNumberExistsState extends AuthState {}

class ProfileInactiveState extends AuthState {}

class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState({
    required this.message,
  });
}
