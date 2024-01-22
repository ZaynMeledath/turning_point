part of 'home_bloc.dart';

sealed class HomeState {
  final int currentIndex;
  // final HomeScreenState? previousState;
  HomeState(this.currentIndex);
}

class TriggeredState extends HomeState {
  TriggeredState(super.currentIndex);
}

class ConnectState extends HomeState {
  ConnectState(super.currentIndex);
}

// class HomeState extends HomeScreenState {
//   HomeState(super.currentIndex, super.previousState);
// }

// class RewardsState extends HomeScreenState {
//   RewardsState(super.currentIndex, super.previousState);
// }

// class ScannerState extends HomeScreenState {
//   ScannerState(super.currentIndex, super.previousState);
// }

// class LuckyDrawState extends HomeScreenState {
//   LuckyDrawState(super.currentIndex, super.previousState);
// }

// class ConnectState extends HomeScreenState {
//   ConnectState(super.currentIndex, super.previousState);
// }
