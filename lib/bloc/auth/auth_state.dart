part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  final String? phone;
  final String? businessName;
  final ContractorModel? contractor;
  final String? refCode;

  const AuthState({
    this.phone,
    this.businessName,
    this.contractor,
    this.refCode,
  });
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState({
    super.phone,
    super.businessName,
    super.contractor,
    super.refCode,
  });
}

class InitialState extends AuthState {}

class SignInState extends AuthState {}

class WhoIsSigningState extends AuthState {}

class OtpVerificationNeededState extends AuthState {
  final String? exception;
  const OtpVerificationNeededState({
    required super.phone,
    required super.businessName,
    required super.contractor,
    required super.refCode,
    this.exception,
  });
}

class OtpVerifiedState extends AuthState {}

class SignedInState extends AuthState {}

class DirectSignedInState extends AuthState {}

class SignUpState extends AuthState {
  final Exception? exception;

  const SignUpState({
    this.exception,
  });
}

class PhoneNumberExistsState extends AuthState {}

class InvalidReferralCodeState extends AuthState {}

class AddContractorDetailsState extends AuthState {}

class ProfileInactiveState extends AuthState {}

class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState({
    required this.message,
  });
}
