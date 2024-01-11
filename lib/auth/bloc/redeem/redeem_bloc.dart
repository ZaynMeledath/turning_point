import 'package:flutter_bloc/flutter_bloc.dart';

part 'redeem_event.dart';
part 'redeem_state.dart';

class RedeemBloc extends Bloc<RedeemEvent, RedeemState> {
  RedeemBloc()
      : super(BuyCouponsState(selectedOptionNumber: 1, redeemPoints: 500)) {
//====================Buy Coupon Event====================//
    on<BuyCouponsPressedEvent>((event, emit) {
      emit(
        BuyCouponsState(selectedOptionNumber: 1, redeemPoints: 500),
      );
    });

//====================Bank Transfer Event====================//
    on<BankTransferPressedEvent>((event, emit) {
      emit(
        BankTransferState(selectedOptionNumber: 2, redeemPoints: 500),
      );
    });

//====================In-App Purchase Event====================//
    on<InAppPurchasePressedEvent>((event, emit) {
      emit(
        InAppPurchaseState(selectedOptionNumber: 3, redeemPoints: 500),
      );
    });

//====================UPI Transfer Event====================//
    on<UpiTransferPressedEvent>((event, emit) {
      emit(
        UpiTransferState(selectedOptionNumber: 4, redeemPoints: 500),
      );
    });

//====================Points Increment Event====================//
    on<PointsIncrementEvent>((event, emit) {
      if (state.redeemPoints + 500 <= 10000) {
        switch (state) {
          case BuyCouponsState():
            emit(
              BuyCouponsState(
                selectedOptionNumber: 1,
                redeemPoints: state.redeemPoints + 500,
              ),
            );
            break;
          case BankTransferState():
            emit(
              BankTransferState(
                selectedOptionNumber: 2,
                redeemPoints: state.redeemPoints + 500,
              ),
            );
            break;
          case InAppPurchaseState():
            emit(
              InAppPurchaseState(
                selectedOptionNumber: 3,
                redeemPoints: state.redeemPoints + 500,
              ),
            );
            break;
          case UpiTransferState():
            emit(
              UpiTransferState(
                selectedOptionNumber: 4,
                redeemPoints: state.redeemPoints + 500,
              ),
            );
            break;
        }
      }
    });

//====================Points Decrement Event====================//
    on<PointsDecrementEvent>((event, emit) {
      if (state.redeemPoints > 500) {
        switch (state) {
          case BuyCouponsState():
            emit(
              BuyCouponsState(
                selectedOptionNumber: 1,
                redeemPoints: state.redeemPoints - 500,
              ),
            );
            break;
          case BankTransferState():
            emit(
              BankTransferState(
                selectedOptionNumber: 2,
                redeemPoints: state.redeemPoints - 500,
              ),
            );
            break;
          case InAppPurchaseState():
            emit(
              InAppPurchaseState(
                selectedOptionNumber: 3,
                redeemPoints: state.redeemPoints - 500,
              ),
            );
            break;
          case UpiTransferState():
            emit(
              UpiTransferState(
                selectedOptionNumber: 4,
                redeemPoints: state.redeemPoints - 500,
              ),
            );
            break;
        }
      }
    });
  }
}
