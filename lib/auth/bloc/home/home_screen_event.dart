part of 'home_screen_bloc.dart';

sealed class HomeScreenEvent {}

class HomePressedEvent extends HomeScreenEvent {}

class RewardsPressedEvent extends HomeScreenEvent {}

class ScannerPressedEvent extends HomeScreenEvent {}

class LuckyDrawPressedEvent extends HomeScreenEvent {}

class ConnectPressedEvent extends HomeScreenEvent {}
