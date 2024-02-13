part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthLoadingState extends AuthState {}

class InitialState extends AuthState {}

class SignInState extends AuthState {}

class WhoIsSigningState extends AuthState {}

// class SignUpState extends AuthState {
//   final bool isContractor;
//   // final bool isLoading;
//   // final String phone;
//   // final String? businessName;
//   // final String? selectedContractor;
//   final UserModel? contractors;
//   SignUpState({
//     required this.isContractor,
//     // required this.isLoading,
//     // required this.phone,
//     // this.businessName,
//     // this.selectedContractor,
//     this.contractors,
//   });
// }

class OtpVerificationNeededState extends AuthState {}

class OtpVerifiedState extends AuthState {}

class SignedInState extends AuthState {}
