import 'package:flutter_bloc/flutter_bloc.dart';

part 'redeem_event.dart';
part 'redeem_state.dart';

class RedeemBloc extends Bloc<RedeemEvent, RedeemState> {
  RedeemBloc() : super(BuyCouponsState()) {
//====================Buy Coupon Event====================//
    on<BuyCouponsPressedEvent>((event, emit) {
      emit(BuyCouponsState());
    });

//====================Bank Transfer Event====================//
    on<BankTransferPressedEvent>((event, emit) {
      emit(BankTransferState());
    });

//====================In-App Purchase Event====================//
    on<InAppPurchasePressedEvent>((event, emit) {
      emit(InAppPurchaseState());
    });

//====================UPI Transfer Event====================//
    on<UpiTransferPressedEvent>((event, emit) {
      emit(UpiTransferState());
    });
  }
}
