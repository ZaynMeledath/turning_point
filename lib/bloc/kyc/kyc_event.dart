part of 'kyc_bloc.dart';

@immutable
sealed class KycEvent {}

class KycLoadEvent extends KycEvent {
  final int tabIndex;
  final String? name;
  final String? email;
  final String? pincode;
  final bool? avoidStatusCheck;
  KycLoadEvent({
    required this.tabIndex,
    this.name,
    this.email,
    this.pincode,
    this.avoidStatusCheck,
  });
}

class KycUpdateEvent extends KycEvent {
  final bool isSavings;
  final String accName;
  final String accNum;
  final String ifsc;

  KycUpdateEvent({
    required this.isSavings,
    required this.accName,
    required this.accNum,
    required this.ifsc,
  });
}

class KycAccountTypeTriggerEvent extends KycEvent {
  final bool isSavings;

  KycAccountTypeTriggerEvent({required this.isSavings});
}

class KycIdUpdateEvent extends KycEvent {}

class KycSelfieUpdateEvent extends KycEvent {}

class KycIdResetEvent extends KycEvent {}
