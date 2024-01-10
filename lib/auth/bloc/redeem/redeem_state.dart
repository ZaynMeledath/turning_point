part of 'redeem_bloc.dart';

sealed class RedeemState {
  final int selectedOptionNumber;
  RedeemState(this.selectedOptionNumber);
}

class BuyCouponsState extends RedeemState {
  BuyCouponsState() : super(1);
}

class BankTransferState extends RedeemState {
  BankTransferState() : super(2);
}

class InAppPurchaseState extends RedeemState {
  InAppPurchaseState() : super(3);
}

class UpiTransferState extends RedeemState {
  UpiTransferState() : super(4);
}
