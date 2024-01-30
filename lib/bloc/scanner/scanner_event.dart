part of 'scanner_bloc.dart';

@immutable
sealed class ScannerEvent {}

class ScannerCodeDetectEvent extends ScannerEvent {}
