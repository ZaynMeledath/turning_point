part of 'redeem_bloc.dart';

sealed class RedeemEvent {}

class BuyCouponsPressedEvent extends RedeemEvent {}

class BankTransferPressedEvent extends RedeemEvent {}

class InAppPurchasePressedEvent extends RedeemEvent {}

class UpiTransferPressedEvent extends RedeemEvent {}

class PointsIncrementEvent extends RedeemEvent {}

class PointsDecrementEvent extends RedeemEvent {}

class AgreeTermsPressedEvent extends RedeemEvent {}
