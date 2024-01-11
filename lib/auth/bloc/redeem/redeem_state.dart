part of 'redeem_bloc.dart';

sealed class RedeemState {
  final int selectedOptionNumber;
  int redeemPoints = 500;
  RedeemState({
    required this.selectedOptionNumber,
    required this.redeemPoints,
  });
}

class BuyCouponsState extends RedeemState {
  BuyCouponsState({
    required super.selectedOptionNumber,
    required super.redeemPoints,
  });
}

class BankTransferState extends RedeemState {
  BankTransferState({
    required super.selectedOptionNumber,
    required super.redeemPoints,
  });
}

class InAppPurchaseState extends RedeemState {
  InAppPurchaseState({
    required super.selectedOptionNumber,
    required super.redeemPoints,
  });
}

class UpiTransferState extends RedeemState {
  UpiTransferState({
    required super.selectedOptionNumber,
    required super.redeemPoints,
  });
}
