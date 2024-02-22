part of 'join_contest_bloc.dart';

sealed class JoinContestState {}

class JoinContestInitialState extends JoinContestState {}

class ContestJoinedState extends JoinContestState {
  final ContestModel contestModel;

  ContestJoinedState(this.contestModel);
}

class JoinContestErrorState extends JoinContestState {
  final Exception exception;

  JoinContestErrorState(this.exception);
}
