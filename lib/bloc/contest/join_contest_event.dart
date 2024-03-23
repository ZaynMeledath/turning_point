part of 'join_contest_bloc.dart';

class JoinContestEvent {
  final ContestModel contestModel;
  final int contestIndex;
  final int entryCount;
  JoinContestEvent({
    required this.contestModel,
    required this.contestIndex,
    required this.entryCount,
  });
}
