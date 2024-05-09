part of 'carpenter_bloc.dart';

@immutable
sealed class CarpenterState {}

class CarpenterInitialState extends CarpenterState {}

class CarpenterLoadingState extends CarpenterState {}

class CarpenterLoadedState extends CarpenterState {
  final CarpentersListModel carpentersListModel;

  CarpenterLoadedState({required this.carpentersListModel});
}

class CarpenterLoadErrorState extends CarpenterState {}
