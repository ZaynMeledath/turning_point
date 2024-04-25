part of 'location_service_bloc.dart';

@immutable
sealed class LocationServiceEvent {}

class LocationServiceStartEvent extends LocationServiceEvent {}
