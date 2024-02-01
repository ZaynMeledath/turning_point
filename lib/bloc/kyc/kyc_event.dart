part of 'kyc_bloc.dart';

@immutable
sealed class KycEvent {}

class KycLoadEvent extends KycEvent {}

class KycUpdateEvent extends KycEvent {
  final String name;
  final String phone;
  final String email;
  final String pincode;
  final bool isSavings;
  final String accName;
  final String accNum;
  final String ifsc;

  KycUpdateEvent({
    required this.pincode,
    required this.name,
    required this.phone,
    required this.email,
    required this.isSavings,
    required this.accName,
    required this.accNum,
    required this.ifsc,
  });
}
