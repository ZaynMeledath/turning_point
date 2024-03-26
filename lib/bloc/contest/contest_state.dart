part of 'contest_bloc.dart';

sealed class ContestState {
  List<ContestModel>? contestModelList;
  List<Map<String, String>>? timeList;
  List<int>? secondsLeftList;
  List<int> entryCount = [];

  ContestState(
      {required this.contestModelList,
      required this.timeList,
      required this.secondsLeftList,
      required this.entryCount});
}

class ContestLoadingState extends ContestState {
  ContestLoadingState()
      : super(
          contestModelList: null,
          timeList: null,
          secondsLeftList: null,
          entryCount: [],
        );
}

class ContestLoadedState extends ContestState {
  ContestLoadedState({
    required super.contestModelList,
    required super.timeList,
    required super.secondsLeftList,
    required super.entryCount,
  });
}
