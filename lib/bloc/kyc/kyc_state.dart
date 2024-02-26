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
  });
}

class KycSubmittedState extends KycState {
  const KycSubmittedState()
      : super(
          name: null,
          email: null,
          phone: null,
          pincode: null,
          isSavings: true,
          idFrontImage: null,
          idBackImage: null,
        );
}
