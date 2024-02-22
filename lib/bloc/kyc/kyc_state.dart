part of 'kyc_bloc.dart';

@immutable
sealed class KycState {
  final String? name;
  final String? phone;
  final String? email;
  final String? pincode;

  const KycState({
    required this.name,
    required this.phone,
    required this.email,
    required this.pincode,
  });
}

final class KycLoadingState extends KycState {
  const KycLoadingState()
      : super(
          name: null,
          email: null,
          phone: null,
          pincode: null,
        );
}

class KycLoadedState extends KycState {
  final bool isLoading;
  final int tabIndex;
  final bool isSavings;
  // final String name;
  // final String phone;
  // final String email;
  // final String pincode;

  const KycLoadedState({
    required this.isLoading,
    required this.tabIndex,
    required this.isSavings,
    required super.name,
    required super.phone,
    required super.email,
    required super.pincode,
  });
}

class KycSubmittedState extends KycState {
  const KycSubmittedState()
      : super(
          name: null,
          email: null,
          phone: null,
          pincode: null,
        );
}
