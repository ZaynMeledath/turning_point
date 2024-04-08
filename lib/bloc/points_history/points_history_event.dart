part of 'points_history_bloc.dart';

@immutable
sealed class PointsHistoryEvent {}

class PointsHistoryLoadEvent extends PointsHistoryEvent {
  PointsHistoryLoadEvent();
}
