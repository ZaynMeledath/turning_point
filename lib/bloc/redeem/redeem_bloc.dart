import 'dart:developer';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/bloc/points/points_bloc.dart';
import 'package:turning_point/constants/constants.dart';
import 'package:turning_point/resources/redeem_repository.dart';
import 'package:turning_point/resources/user_repository.dart';

part 'redeem_event.dart';
part 'redeem_state.dart';

class RedeemBloc extends Bloc<RedeemEvent, RedeemState> {
  bool status = false;
  RedeemBloc()
      : super(BuyCouponsState(
          selectedOptionNumber: 3,
          redeemPoints: DEFAULT_REDEEM_POINTS,
          isTermsAgreed: false,
          isLoading: false,
        )) {
    final redeemRepo = RedeemRepository();

//====================Bank Transfer Event====================//
    on<BankTransferPressedEvent>((event, emit) {
      emit(
        BankTransferState(
          selectedOptionNumber: 1,
          redeemPoints: DEFAULT_REDEEM_POINTS,
          isTermsAgreed: false,
          isLoading: false,
        ),
      );
    });

//====================UPI Transfer Event====================//
    on<UpiTransferPressedEvent>((event, emit) {
      emit(
        UpiTransferState(
          selectedOptionNumber: 2,
          redeemPoints: DEFAULT_REDEEM_POINTS,
          isTermsAgreed: false,
          isLoading: false,
        ),
      );
    });

//====================Buy Coupon Event====================//
    on<BuyCouponsPressedEvent>((event, emit) {
      emit(
        BuyCouponsState(
          selectedOptionNumber: 3,
          redeemPoints: DEFAULT_REDEEM_POINTS,
          isTermsAgreed: false,
          isLoading: false,
        ),
      );
    });

// //====================In-App Purchase Event====================//
//     on<InAppPurchasePressedEvent>((event, emit) {
//       emit(
//         InAppPurchaseState(
//           selectedOptionNumber: 4,
//           redeemPoints: DEFAULT_REDEEM_POINTS,
//           isTermsAgreed: false,
//           isLoading: false,
//         ),
//       );
//     });

//====================Points Increment Event====================//
    on<PointsIncrementEvent>((event, emit) {
      final user = UserRepository.getUserFromPreference()!;

      if (state.redeemPoints + DEFAULT_REDEEM_POINTS <= user.data!.points!) {
        switch (state) {
          case BuyCouponsState():
            emit(
              BuyCouponsState(
                selectedOptionNumber: state.selectedOptionNumber,
                redeemPoints: state.redeemPoints + DEFAULT_REDEEM_POINTS,
                isTermsAgreed: state.isTermsAgreed,
                isLoading: false,
              ),
            );
            break;
          case BankTransferState():
            emit(
              BankTransferState(
                selectedOptionNumber: state.selectedOptionNumber,
                redeemPoints: state.redeemPoints + DEFAULT_REDEEM_POINTS,
                isTermsAgreed: state.isTermsAgreed,
                isLoading: false,
              ),
            );
            break;
          case InAppPurchaseState():
            emit(
              InAppPurchaseState(
                selectedOptionNumber: state.selectedOptionNumber,
                redeemPoints: state.redeemPoints + DEFAULT_REDEEM_POINTS,
                isTermsAgreed: state.isTermsAgreed,
                isLoading: false,
              ),
            );
            break;
          case UpiTransferState():
            emit(
              UpiTransferState(
                selectedOptionNumber: state.selectedOptionNumber,
                redeemPoints: state.redeemPoints + DEFAULT_REDEEM_POINTS,
                isTermsAgreed: state.isTermsAgreed,
                isLoading: false,
              ),
            );
            break;
        }
      }
    });

//====================Points Decrement Event====================//
    on<PointsDecrementEvent>((event, emit) {
      if (state.redeemPoints > DEFAULT_REDEEM_POINTS) {
        switch (state) {
          case BuyCouponsState():
            emit(
              BuyCouponsState(
                selectedOptionNumber: state.selectedOptionNumber,
                redeemPoints: state.redeemPoints - DEFAULT_REDEEM_POINTS,
                isTermsAgreed: state.isTermsAgreed,
                isLoading: false,
              ),
            );
            break;
          case BankTransferState():
            emit(
              BankTransferState(
                selectedOptionNumber: state.selectedOptionNumber,
                redeemPoints: state.redeemPoints - DEFAULT_REDEEM_POINTS,
                isTermsAgreed: state.isTermsAgreed,
                isLoading: false,
              ),
            );
            break;
          case InAppPurchaseState():
            emit(
              InAppPurchaseState(
                selectedOptionNumber: state.selectedOptionNumber,
                redeemPoints: state.redeemPoints - DEFAULT_REDEEM_POINTS,
                isTermsAgreed: state.isTermsAgreed,
                isLoading: false,
              ),
            );
            break;
          case UpiTransferState():
            emit(
              UpiTransferState(
                selectedOptionNumber: state.selectedOptionNumber,
                redeemPoints: state.redeemPoints - DEFAULT_REDEEM_POINTS,
                isTermsAgreed: state.isTermsAgreed,
                isLoading: false,
              ),
            );
            break;
        }
      }
    });

//====================Agree Terms Event====================//
    on<AgreeTermsPressedEvent>((event, emit) {
      switch (state) {
        case BuyCouponsState():
          emit(
            BuyCouponsState(
              selectedOptionNumber: state.selectedOptionNumber,
              redeemPoints: state.redeemPoints,
              isTermsAgreed: !state.isTermsAgreed,
              isLoading: false,
            ),
          );
          break;
        case BankTransferState():
          emit(
            BankTransferState(
              selectedOptionNumber: state.selectedOptionNumber,
              redeemPoints: state.redeemPoints,
              isTermsAgreed: !state.isTermsAgreed,
              isLoading: false,
            ),
          );
          break;
        case InAppPurchaseState():
          emit(
            InAppPurchaseState(
              selectedOptionNumber: state.selectedOptionNumber,
              redeemPoints: state.redeemPoints,
              isTermsAgreed: !state.isTermsAgreed,
              isLoading: false,
            ),
          );
          break;
        case UpiTransferState():
          emit(
            UpiTransferState(
              selectedOptionNumber: state.selectedOptionNumber,
              redeemPoints: state.redeemPoints,
              isTermsAgreed: !state.isTermsAgreed,
              isLoading: false,
            ),
          );
          break;
      }
    });

//====================Redeem Button Pressed Event====================//
    on<RedeemButtonPressedEvent>((event, emit) async {
      try {
        switch (state) {
          case BuyCouponsState():
            return emit(
              BuyCouponsState(
                selectedOptionNumber: state.selectedOptionNumber,
                redeemPoints: DEFAULT_REDEEM_POINTS,
                isTermsAgreed: state.isTermsAgreed,
                isLoading: false,
              ),
            );

          case BankTransferState():
            emit(
              BankTransferState(
                selectedOptionNumber: state.selectedOptionNumber,
                redeemPoints: state.redeemPoints,
                isTermsAgreed: state.isTermsAgreed,
                isLoading: true,
              ),
            );
            await redeemRepo.redeemBank(
              points: state.redeemPoints,
            );
            pointsBloc
                .add(PointsLoadEvent(avoidGettingUserFromPreference: true));
            return emit(
              BankTransferState(
                selectedOptionNumber: state.selectedOptionNumber,
                redeemPoints: state.redeemPoints,
                isTermsAgreed: state.isTermsAgreed,
                isLoading: false,
              ),
            );
          case InAppPurchaseState():
            emit(
              InAppPurchaseState(
                selectedOptionNumber: state.selectedOptionNumber,
                redeemPoints: state.redeemPoints,
                isTermsAgreed: state.isTermsAgreed,
                isLoading: true,
              ),
            );

          case UpiTransferState():
            emit(
              UpiTransferState(
                selectedOptionNumber: state.selectedOptionNumber,
                redeemPoints: state.redeemPoints,
                isTermsAgreed: state.isTermsAgreed,
                isLoading: true,
              ),
            );

            await redeemRepo.redeemUpi(
              points: state.redeemPoints,
              upiId: event.upiId!,
            );
            pointsBloc
                .add(PointsLoadEvent(avoidGettingUserFromPreference: true));
            emit(
              UpiTransferState(
                selectedOptionNumber: state.selectedOptionNumber,
                redeemPoints: state.redeemPoints,
                isTermsAgreed: state.isTermsAgreed,
                isLoading: false,
              ),
            );
        }
      } catch (e) {
        throw Exception(e);
      }
    });

//====================State Change Logger====================//
    on<ResetStateEvent>((event, emit) {
      emit(BuyCouponsState(
        selectedOptionNumber: 3,
        redeemPoints: DEFAULT_REDEEM_POINTS,
        isTermsAgreed: false,
        isLoading: false,
      ));
    });
  }

//====================State Change Logger====================//
  @override
  void onChange(Change<RedeemState> change) {
    log('CURRENT STATE : ${change.currentState}');
    log('NEXT STATE: ${change.nextState}');
    super.onChange(change);
  }
}

final redeemBloc = RedeemBloc();
