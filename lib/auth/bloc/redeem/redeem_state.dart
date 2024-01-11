part of 'redeem_bloc.dart';

sealed class RedeemState {
  final int selectedOptionNumber;
  int redeemPoints = 500;
  bool isTermsAgreed;
  RedeemState({
    required this.selectedOptionNumber,
    required this.redeemPoints,
    required this.isTermsAgreed,
  });
}

class BuyCouponsState extends RedeemState {
  BuyCouponsState({
    required super.selectedOptionNumber,
    required super.redeemPoints,
    required super.isTermsAgreed,
  });
}

class BankTransferState extends RedeemState {
  BankTransferState({
    required super.selectedOptionNumber,
    required super.redeemPoints,
    required super.isTermsAgreed,
  });
}

class InAppPurchaseState extends RedeemState {
  InAppPurchaseState({
    required super.selectedOptionNumber,
    required super.redeemPoints,
    required super.isTermsAgreed,
  });
}

class UpiTransferState extends RedeemState {
  UpiTransferState({
    required super.selectedOptionNumber,
    required super.redeemPoints,
    required super.isTermsAgreed,
  });
}
