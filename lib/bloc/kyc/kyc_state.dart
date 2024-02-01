part of 'kyc_bloc.dart';

@immutable
sealed class KycState {}

final class KycLoadingState extends KycState {}

class KycLoadedState extends KycState {
  final bool isLoading;
  final String name;
  final String phone;
  final String email;
  final String pincode;

  KycLoadedState({
    required this.isLoading,
    required this.name,
    required this.phone,
    required this.email,
    required this.pincode,
  });
}

class KycSubmittedState extends KycState {}
