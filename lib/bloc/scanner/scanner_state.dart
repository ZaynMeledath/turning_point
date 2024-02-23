part of 'scanner_bloc.dart';

@immutable
sealed class ScannerState {
  final CouponModel? couponModel;
  const ScannerState({this.couponModel});
}

final class ScannerInitialState extends ScannerState {}

class ScannerCodeDetectedState extends ScannerState {
  const ScannerCodeDetectedState({required super.couponModel});
}
