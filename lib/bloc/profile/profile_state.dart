part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final UserModel userModel;

  ProfileLoadedState({required this.userModel});
}

// class ProfileUpdateLoadingState extends ProfileState {}

class ProfileLoadErrorState extends ProfileState {}
