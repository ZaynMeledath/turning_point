part of 'contest_bloc.dart';

sealed class ContestState {
  List<ContestModel>? contestModelList;
  List<Map<String, String>>? timeList;
  List<int>? secondsLeftList;
  List<int> entryCounter = [];

  ContestState(
      {required this.contestModelList,
      required this.timeList,
      required this.secondsLeftList,
      required this.entryCounter});
}

class ContestLoadingState extends ContestState {
  ContestLoadingState()
      : super(
          contestModelList: null,
          timeList: null,
          secondsLeftList: null,
          entryCounter: [],
        );
}

class ContestLoadedState extends ContestState {
  ContestLoadedState({
    required super.contestModelList,
    required super.timeList,
    required super.secondsLeftList,
    required super.entryCounter,
  });
}
