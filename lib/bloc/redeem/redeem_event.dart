part of 'redeem_bloc.dart';

@immutable
sealed class RedeemEvent {}

class BuyCouponsPressedEvent extends RedeemEvent {}

class BankTransferPressedEvent extends RedeemEvent {}

class InAppPurchasePressedEvent extends RedeemEvent {}

class UpiTransferPressedEvent extends RedeemEvent {}

class PointsIncrementEvent extends RedeemEvent {}

class PointsDecrementEvent extends RedeemEvent {}

class AgreeTermsPressedEvent extends RedeemEvent {}

class RedeemButtonPressedEvent extends RedeemEvent {
  final String? upiId;

  RedeemButtonPressedEvent({this.upiId});
}

class ResetStateEvent extends RedeemEvent {}
