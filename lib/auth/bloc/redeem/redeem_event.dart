part of 'redeem_bloc.dart';

sealed class RedeemEvent {}

class BuyCouponsPressedEvent extends RedeemEvent {}

class BankTransferPressedEvent extends RedeemEvent {}

class InAppPurchasePressedEvent extends RedeemEvent {}

class UpiTransferPressedEvent extends RedeemEvent {}
