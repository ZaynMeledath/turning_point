part of 'lucky_draw_bloc.dart';

sealed class LuckyDrawState {
  ContestModel? contestModel;
  Map<String, String>? timeMap;
  int? secondsLeft;
  int? prizeIndex;
  final bool? scaleAnimate;
  final bool? opacityAnimate;
  final bool? repeatedScaleAnimate;

  LuckyDrawState({
    required this.contestModel,
    required this.timeMap,
    required this.secondsLeft,
    this.prizeIndex,
    this.scaleAnimate,
    this.opacityAnimate,
    this.repeatedScaleAnimate,
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
  LuckyDrawWinnersDisplayState({
    required super.contestModel,
    required super.timeMap,
    required super.secondsLeft,
    required super.prizeIndex,
    required super.scaleAnimate,
    required super.opacityAnimate,
    super.repeatedScaleAnimate,
  });
}
