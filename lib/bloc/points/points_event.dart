part of 'points_bloc.dart';

sealed class PointsEvent {}

class PointsLoadEvent extends PointsEvent {
  final bool? avoidGettingUserFromPreference;

  PointsLoadEvent({this.avoidGettingUserFromPreference});
}
