part of 'contest_bloc.dart';

@immutable
sealed class ContestState {}

class ContestInitialState extends ContestState {}

class ContestLoadingState extends ContestState {}

class ContestLoadedState extends ContestState {
  final List<ContestModel> contestModelList;

  ContestLoadedState({required this.contestModelList});
}
