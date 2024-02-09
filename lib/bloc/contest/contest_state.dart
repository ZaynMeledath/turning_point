part of 'contest_bloc.dart';

sealed class ContestState {
  List<ContestModel>? contestModelList;
  List<Map<String, String>>? timeList;
  List<int>? secondsLeftList;

  ContestState({
    required this.contestModelList,
    required this.timeList,
    required this.secondsLeftList,
  });
}

class ContestLoadingState extends ContestState {
  ContestLoadingState()
      : super(
          contestModelList: null,
          timeList: null,
          secondsLeftList: null,
        );
}

class ContestLoadedState extends ContestState {
  ContestLoadedState({
    required super.contestModelList,
    required super.timeList,
    required super.secondsLeftList,
  });
}
