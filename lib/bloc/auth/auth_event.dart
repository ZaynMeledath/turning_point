part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthInitializeEvent extends AuthEvent {}

class GoogleSignInEvent extends AuthEvent {
  final bool? isUpdating;
  GoogleSignInEvent({this.isUpdating});
}

class SignUpEvent extends AuthEvent {
  final String phone;
  final ContractorModel? contractor;
  final String? businessName;
  final TextEditingController otpController;
  SignUpEvent({
    required this.phone,
    this.contractor,
    this.businessName,
    required this.otpController,
  });
}

class UpdateContractor extends AuthEvent {
  final String contractor;

  UpdateContractor({required this.contractor});
}

class VerifyOtpEvent extends AuthEvent {
  final String otp;
  VerifyOtpEvent(this.otp);
}

class SignOutEvent extends AuthEvent {}
