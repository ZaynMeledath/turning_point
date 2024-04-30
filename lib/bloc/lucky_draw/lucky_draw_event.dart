part of 'lucky_draw_bloc.dart';

@immutable
sealed class LuckyDrawEvent {}

class LuckyDrawLoadEvent extends LuckyDrawEvent {}

class LuckyDrawTimerUpdateEvent extends LuckyDrawEvent {}

class LuckyDrawTimerDisposeEvent extends LuckyDrawEvent {}

class LuckyDrawWinnersDisplayEvent extends LuckyDrawEvent {
  final int secondsLeft;

  LuckyDrawWinnersDisplayEvent({required this.secondsLeft});
}

class LuckyDrawWinnersDisplayTimerEvent extends LuckyDrawEvent {}
