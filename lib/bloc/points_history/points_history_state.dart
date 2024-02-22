part of 'points_history_bloc.dart';

@immutable
sealed class PointsHistoryState {}

class PointsHistoryLoadingState extends PointsHistoryState {}

class PointsHistoryLoadedState extends PointsHistoryState {
  final List<PointsHistoryModel>? pointsHistoryModel;
  PointsHistoryLoadedState(this.pointsHistoryModel);
}

class NoPointsHistoryState extends PointsHistoryState {}
