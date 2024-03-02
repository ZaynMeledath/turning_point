part of 'join_contest_bloc.dart';

class JoinContestEvent {
  final ContestModel contestModel;
  final int contestIndex;
  JoinContestEvent({
    required this.contestModel,
    required this.contestIndex,
  });
}
