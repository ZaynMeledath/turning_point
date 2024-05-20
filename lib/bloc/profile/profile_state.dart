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
  final dynamic exception;

  ProfileLoadedState({
    required this.isLoading,
    required super.userModel,
    required this.isContractor,
    required this.isContractorTemp,
    this.exception,
    this.verifyOtp,
  });
}

class ProfileInactiveState extends ProfileState {}

class ProfileLoadErrorState extends ProfileState {
  final bool isLoading;

  ProfileLoadErrorState({required this.isLoading});
}
