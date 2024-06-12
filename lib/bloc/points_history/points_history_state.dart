part of 'points_history_bloc.dart';

@immutable
sealed class PointsHistoryState {
  final int? page;
  final List<PointsHistoryModel>? pointsHistoryModel;
  const PointsHistoryState({
    this.page,
    this.pointsHistoryModel,
  });
}

class PointsHistoryLoadingState extends PointsHistoryState {}

class PointsHistoryLoadedState extends PointsHistoryState {
  const PointsHistoryLoadedState({
    super.pointsHistoryModel,
    super.page,
  });
}

class NoPointsHistoryState extends PointsHistoryState {}

class PointsHistoryErrorState extends PointsHistoryState {
  final bool isLoading;
  const PointsHistoryErrorState({required this.isLoading});
}
