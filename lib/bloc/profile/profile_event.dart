part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class ProfileLoadEvent extends ProfileEvent {
  final bool? avoidGettingFromPreference;
  ProfileLoadEvent({this.avoidGettingFromPreference});
}

class ProfileUpdateEvent extends ProfileEvent {
  final bool isContractor;
  final String name;
  final String phone;
  final String address;
  final String? businessName;
  final String email;
  final ContractorModel? contractor;

  ProfileUpdateEvent({
    required this.isContractor,
    required this.name,
    required this.phone,
    required this.address,
    required this.businessName,
    required this.email,
    required this.contractor,
  });
}

class ProfileRadioTriggerEvent extends ProfileEvent {
  final bool isContractor;

  ProfileRadioTriggerEvent({required this.isContractor});
}

class ProfilePictureUpdateEvent extends ProfileEvent {}

class ProfileEmailUpdateEvent extends ProfileEvent {}

class ProfilePhoneUpdateEvent extends ProfileEvent {
  final String phone;
  final TextEditingController otpController;
  ProfilePhoneUpdateEvent({
    required this.phone,
    required this.otpController,
  });
}

class ProfileVerifyOtpEvent extends ProfileEvent {
  final String phone;
  final String otp;

  ProfileVerifyOtpEvent({
    required this.phone,
    required this.otp,
  });
}
