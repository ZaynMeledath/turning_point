part of 'home_bloc.dart';

sealed class HomeEvent {}

class TriggerEvent extends HomeEvent {
  final int index;
  TriggerEvent(this.index);
}
