part of 'profile_bloc.dart';

sealed class ProfileState {
  UserModel? userModel;
  ProfileState({this.userModel});
}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final bool isLoading;
  final bool isContractor;
  final bool isContractorTemp;
  final bool? verifyOtp;

  ProfileLoadedState({
    required this.isLoading,
    required super.userModel,
    required this.isContractor,
    required this.isContractorTemp,
    this.verifyOtp,
  });
}

class ProfileInactiveState extends ProfileState {}

class ProfileLoadErrorState extends ProfileState {}
