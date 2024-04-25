part of 'contest_bloc.dart';

@immutable
sealed class ContestEvent {}

class ContestLoadEvent extends ContestEvent {}

class ContestTimerUpdateEvent extends ContestEvent {}

class ContestTimerDisposeEvent extends ContestEvent {}

class ContestEntryIncrementEvent extends ContestEvent {
  final int contestIndex;
  ContestEntryIncrementEvent({required this.contestIndex});
}

class ContestEntryDecrementEvent extends ContestEvent {
  final int contestIndex;
  ContestEntryDecrementEvent({required this.contestIndex});
}

class ContestLoadAgainEvent extends ContestEvent {}
