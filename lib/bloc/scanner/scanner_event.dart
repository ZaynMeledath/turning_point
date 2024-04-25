part of 'scanner_bloc.dart';

@immutable
sealed class ScannerEvent {}

class ScannerCodeDetectEvent extends ScannerEvent {
  final String couponId;
  ScannerCodeDetectEvent({required this.couponId});
}

class ScannerInitialStateTriggerEvent extends ScannerEvent {}
