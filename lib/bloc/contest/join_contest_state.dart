part of 'join_contest_bloc.dart';

sealed class JoinContestState {}

class JoinContestInitialState extends JoinContestState {}

class ContestJoinedState extends JoinContestState {}

class JoinContestErrorState extends JoinContestState {
  final Exception exception;

  JoinContestErrorState(this.exception);
}
