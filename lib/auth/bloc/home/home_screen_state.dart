part of 'home_screen_bloc.dart';

sealed class HomeScreenState {
  final int currentIndex;
  final HomeScreenState? previousState;
  HomeScreenState(this.currentIndex, this.previousState);
}

class HomeState extends HomeScreenState {
  HomeState(super.currentIndex, super.previousState);
}

class RewardsState extends HomeScreenState {
  RewardsState(super.currentIndex, super.previousState);
}

class ScannerState extends HomeScreenState {
  ScannerState(super.currentIndex, super.previousState);
}

class LuckyDrawState extends HomeScreenState {
  LuckyDrawState(super.currentIndex, super.previousState);
}

class ConnectState extends HomeScreenState {
  ConnectState(super.currentIndex, super.previousState);
}
