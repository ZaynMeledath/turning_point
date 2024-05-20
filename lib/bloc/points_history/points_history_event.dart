part of 'points_history_bloc.dart';

@immutable
sealed class PointsHistoryEvent {}

class PointsHistoryLoadEvent extends PointsHistoryEvent {
  final bool? isReloading;
  PointsHistoryLoadEvent({this.isReloading});
}

class PointsHistoryErrorStateReloadEvent extends PointsHistoryEvent {}
