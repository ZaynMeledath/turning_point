part of 'lucky_draw_bloc.dart';

sealed class LuckyDrawState {
  ContestModel? contestModel;
  Map<String, String>? timeMap;
  int? secondsLeft;

  LuckyDrawState({
    required this.contestModel,
    required this.timeMap,
    required this.secondsLeft,
  });
}

class LuckyDrawLoadingState extends LuckyDrawState {
  LuckyDrawLoadingState()
      : super(
          contestModel: null,
          timeMap: null,
          secondsLeft: null,
        );
}

class LuckyDrawLoadedState extends LuckyDrawState {
  LuckyDrawLoadedState({
    required super.contestModel,
    required super.timeMap,
    required super.secondsLeft,
  });
}

class LuckyDrawWinnersDisplayState extends LuckyDrawState {
  final int prizeToDisplay;
  LuckyDrawWinnersDisplayState({
    required super.contestModel,
    required super.timeMap,
    required super.secondsLeft,
    required this.prizeToDisplay,
  });
}
