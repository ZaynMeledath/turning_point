part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final bool isLoading;
  final UserModel userModel;
  final bool isContractor;

  ProfileLoadedState({
    required this.isLoading,
    required this.userModel,
    required this.isContractor,
  });
}

class ProfileInactiveState extends ProfileState {}

class ProfileLoadErrorState extends ProfileState {}
