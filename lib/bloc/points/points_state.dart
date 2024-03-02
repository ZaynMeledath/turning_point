part of 'points_bloc.dart';

sealed class PointsState {
  final int? points;
  PointsState({required this.points});
}

class InitialPointsState extends PointsState {
  InitialPointsState() : super(points: null);
}

class PointsLoadedState extends PointsState {
  PointsLoadedState({required super.points});
}
