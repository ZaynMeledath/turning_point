part of 'home_bloc.dart';

sealed class HomeState {
  final int currentIndex;
  HomeState(this.currentIndex);
}

class TriggeredState extends HomeState {
  TriggeredState(super.currentIndex);
}

class ConnectState extends HomeState {
  ConnectState(super.currentIndex);
}
