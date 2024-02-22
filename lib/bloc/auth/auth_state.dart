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
  const OtpVerificationNeededState({
    required super.phone,
    required super.businessName,
    required super.contractor,
  });
}

class OtpVerifiedState extends AuthState {}

class SignedInState extends AuthState {}
