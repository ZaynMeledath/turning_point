part of 'redeem_bloc.dart';

sealed class RedeemState {
  final int selectedOptionNumber;
  int redeemPoints = 500;
  bool isTermsAgreed;
  bool isLoading = false;
  RedeemState({
    required this.selectedOptionNumber,
    required this.redeemPoints,
    required this.isTermsAgreed,
    required this.isLoading,
  });
}

class BuyCouponsState extends RedeemState {
  final String? coupon;
  BuyCouponsState({
    required super.selectedOptionNumber,
    required super.redeemPoints,
    required super.isTermsAgreed,
    required super.isLoading,
    this.coupon,
  });
}

class BankTransferState extends RedeemState {
  BankTransferState({
    required super.selectedOptionNumber,
    required super.redeemPoints,
    required super.isTermsAgreed,
    required super.isLoading,
  });
}

class InAppPurchaseState extends RedeemState {
  InAppPurchaseState({
    required super.selectedOptionNumber,
    required super.redeemPoints,
    required super.isTermsAgreed,
    required super.isLoading,
  });
}

class UpiTransferState extends RedeemState {
  UpiTransferState({
    required super.selectedOptionNumber,
    required super.redeemPoints,
    required super.isTermsAgreed,
    required super.isLoading,
  });
}
