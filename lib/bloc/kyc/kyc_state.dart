part of 'kyc_bloc.dart';

@immutable
sealed class KycState {
  final String? name;
  final String? phone;
  final String? email;
  final String? pincode;
  final bool isSavings;
  final File? idDisplayImage;
  final String? idFrontImage;
  final String? idBackImage;
  final String? selfie;

  // final User

  const KycState({
    required this.name,
    required this.phone,
    required this.email,
    required this.pincode,
    required this.isSavings,
    this.idDisplayImage,
    required this.idFrontImage,
    required this.idBackImage,
    required this.selfie,
  });
}

final class KycLoadingState extends KycState {
  const KycLoadingState()
      : super(
          name: null,
          email: null,
          phone: null,
          pincode: null,
          isSavings: true,
          idFrontImage: null,
          idBackImage: null,
          selfie: null,
        );
}

class KycLoadedState extends KycState {
  final bool isLoading;
  final int tabIndex;

  const KycLoadedState({
    required this.isLoading,
    required this.tabIndex,
    required super.isSavings,
    required super.name,
    required super.phone,
    required super.email,
    required super.pincode,
    super.idDisplayImage,
    required super.idFrontImage,
    required super.idBackImage,
    required super.selfie,
  });
}

class KycSubmittedState extends KycState {
  const KycSubmittedState({
    required super.name,
    required super.phone,
    required super.email,
    required super.pincode,
    required super.isSavings,
    required super.idFrontImage,
    required super.idBackImage,
    required super.selfie,
  });
}

class KycVerifiedState extends KycState {
  const KycVerifiedState({
    required super.name,
    required super.phone,
    required super.email,
    required super.pincode,
    required super.isSavings,
    required super.idFrontImage,
    required super.idBackImage,
    required super.selfie,
  });
}

class KycRejectedState extends KycState {
  const KycRejectedState({
    required super.name,
    required super.phone,
    required super.email,
    required super.pincode,
    required super.isSavings,
    required super.idFrontImage,
    required super.idBackImage,
    required super.selfie,
  });
}

class KycErrorState extends KycState {
  const KycErrorState()
      : super(
          name: null,
          email: null,
          phone: null,
          pincode: null,
          isSavings: true,
          idFrontImage: null,
          idBackImage: null,
          selfie: null,
        );
}
