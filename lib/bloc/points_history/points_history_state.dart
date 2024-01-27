part of 'points_history_bloc.dart';

sealed class PointsHistoryState {
  final List<Data>? pointsHistoryModel;

  PointsHistoryState(this.pointsHistoryModel);
}

class PointsHistoryLoadingState extends PointsHistoryState {
  PointsHistoryLoadingState() : super(null);
}

class PointsHistoryLoadedState extends PointsHistoryState {
  PointsHistoryLoadedState(super.pointsHistoryModel);
}

class NoPointsHistoryState extends PointsHistoryState {
  NoPointsHistoryState() : super(null);
}
