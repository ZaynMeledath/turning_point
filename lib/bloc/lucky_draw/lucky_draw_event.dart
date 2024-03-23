part of 'lucky_draw_bloc.dart';

@immutable
sealed class LuckyDrawEvent {}

class LuckyDrawLoadEvent extends LuckyDrawEvent {}

class LuckyDrawTimerUpdateEvent extends LuckyDrawEvent {}

class LuckyDrawTimerDisposeEvent extends LuckyDrawEvent {}

class LuckyDrawWinnersDisplayEvent extends LuckyDrawEvent {}

class LuckyDrawLoadAgainEvent extends LuckyDrawEvent {}
