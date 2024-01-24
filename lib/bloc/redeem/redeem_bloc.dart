import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/resources/user_repository.dart';

part 'redeem_event.dart';
part 'redeem_state.dart';

class RedeemBloc extends Bloc<RedeemEvent, RedeemState> {
  RedeemBloc()
      : super(BuyCouponsState(
          selectedOptionNumber: 1,
          redeemPoints: 500,
          isTermsAgreed: false,
        )) {
//====================Buy Coupon Event====================//
    on<BuyCouponsPressedEvent>((event, emit) {
      emit(
        BuyCouponsState(
          selectedOptionNumber: 1,
          redeemPoints: 500,
          isTermsAgreed: false,
        ),
      );
    });

//====================Bank Transfer Event====================//
    on<BankTransferPressedEvent>((event, emit) {
      emit(
        BankTransferState(
          selectedOptionNumber: 2,
          redeemPoints: 500,
          isTermsAgreed: false,
        ),
      );
    });

//====================In-App Purchase Event====================//
    on<InAppPurchasePressedEvent>((event, emit) {
      emit(
        InAppPurchaseState(
          selectedOptionNumber: 3,
          redeemPoints: 500,
          isTermsAgreed: false,
        ),
      );
    });

//====================UPI Transfer Event====================//
    on<UpiTransferPressedEvent>((event, emit) {
      emit(
        UpiTransferState(
          selectedOptionNumber: 4,
          redeemPoints: 500,
          isTermsAgreed: false,
        ),
      );
    });

//====================Points Increment Event====================//
    on<PointsIncrementEvent>((event, emit) {
      final user = UserRepository.getUserFromPreference()!;

      if (state.redeemPoints + 500 <= user.data!.points!) {
        switch (state) {
          case BuyCouponsState():
            emit(
              BuyCouponsState(
                selectedOptionNumber: state.selectedOptionNumber,
                redeemPoints: state.redeemPoints + 500,
                isTermsAgreed: state.isTermsAgreed,
              ),
            );
            break;
          case BankTransferState():
            emit(
              BankTransferState(
                selectedOptionNumber: state.selectedOptionNumber,
                redeemPoints: state.redeemPoints + 500,
                isTermsAgreed: state.isTermsAgreed,
              ),
            );
            break;
          case InAppPurchaseState():
            emit(
              InAppPurchaseState(
                selectedOptionNumber: state.selectedOptionNumber,
                redeemPoints: state.redeemPoints + 500,
                isTermsAgreed: state.isTermsAgreed,
              ),
            );
            break;
          case UpiTransferState():
            emit(
              UpiTransferState(
                selectedOptionNumber: state.selectedOptionNumber,
                redeemPoints: state.redeemPoints + 500,
                isTermsAgreed: state.isTermsAgreed,
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
                selectedOptionNumber: state.selectedOptionNumber,
                redeemPoints: state.redeemPoints - 500,
                isTermsAgreed: state.isTermsAgreed,
              ),
            );
            break;
          case BankTransferState():
            emit(
              BankTransferState(
                selectedOptionNumber: state.selectedOptionNumber,
                redeemPoints: state.redeemPoints - 500,
                isTermsAgreed: state.isTermsAgreed,
              ),
            );
            break;
          case InAppPurchaseState():
            emit(
              InAppPurchaseState(
                selectedOptionNumber: state.selectedOptionNumber,
                redeemPoints: state.redeemPoints - 500,
                isTermsAgreed: state.isTermsAgreed,
              ),
            );
            break;
          case UpiTransferState():
            emit(
              UpiTransferState(
                selectedOptionNumber: state.selectedOptionNumber,
                redeemPoints: state.redeemPoints - 500,
                isTermsAgreed: state.isTermsAgreed,
              ),
            );
            break;
        }
      }
    });

//====================Points Decrement Event====================//
    on<AgreeTermsPressedEvent>((event, emit) {
      switch (state) {
        case BuyCouponsState():
          emit(
            BuyCouponsState(
              selectedOptionNumber: 1,
              redeemPoints: state.redeemPoints,
              isTermsAgreed: !state.isTermsAgreed,
            ),
          );
          break;
        case BankTransferState():
          emit(
            BankTransferState(
              selectedOptionNumber: 2,
              redeemPoints: state.redeemPoints,
              isTermsAgreed: !state.isTermsAgreed,
            ),
          );
          break;
        case InAppPurchaseState():
          emit(
            InAppPurchaseState(
              selectedOptionNumber: 3,
              redeemPoints: state.redeemPoints,
              isTermsAgreed: !state.isTermsAgreed,
            ),
          );
          break;
        case UpiTransferState():
          emit(
            UpiTransferState(
              selectedOptionNumber: 4,
              redeemPoints: state.redeemPoints,
              isTermsAgreed: !state.isTermsAgreed,
            ),
          );
          break;
      }
    });
  }
}
