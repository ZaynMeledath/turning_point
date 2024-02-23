part of 'scanner_bloc.dart';

@immutable
sealed class ScannerEvent {}

class ScannerCodeDetectEvent extends ScannerEvent {
  final BarcodeCapture capture;
  ScannerCodeDetectEvent({required this.capture});
}

class ScannerInitialStateTriggerEvent extends ScannerEvent {}
