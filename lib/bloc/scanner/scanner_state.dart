part of 'scanner_bloc.dart';

@immutable
sealed class ScannerState {}

final class ScannerInitial extends ScannerState {}

class CodeDetectedState extends ScannerState {}
