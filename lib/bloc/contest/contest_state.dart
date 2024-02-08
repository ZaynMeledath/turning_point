part of 'contest_bloc.dart';

@immutable
sealed class ContestState {}

class ContestLoadingState extends ContestState {}

class ContestLoadedState extends ContestState {
  final List<ContestModel> contestModelList;
  final List<Map<String, String>> timeList;

  ContestLoadedState({
    required this.contestModelList,
    required this.timeList,
  });
}
