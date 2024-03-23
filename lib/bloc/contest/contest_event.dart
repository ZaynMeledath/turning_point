part of 'contest_bloc.dart';

@immutable
sealed class ContestEvent {}

class ContestLoadEvent extends ContestEvent {}

class ContestTimerUpdateEvent extends ContestEvent {}

class ContestTimerDisposeEvent extends ContestEvent {}

class ContestEntryIncrementEvent extends ContestEvent {}

class ContestEntryDecrementEvent extends ContestEvent {}

class ContestLoadAgainEvent extends ContestEvent {}
