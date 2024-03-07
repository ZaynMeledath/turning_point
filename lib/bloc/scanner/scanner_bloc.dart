import 'dart:developer';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:turning_point/bloc/points/points_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/model/coupon_model.dart';
import 'package:turning_point/resources/scanner_repository.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/service/Exception/scanner_exceptions.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  final scannerRepo = ScannerRepository();
  ScannerBloc() : super(ScannerInitialState()) {
//====================Scanner Code Detect Event====================//
    on<ScannerCodeDetectEvent>((event, emit) async {
      try {
        final List<Barcode> barcodes = event.capture.barcodes;
        if (barcodes.isNotEmpty) {
          final couponId = barcodes[0].rawValue!;
          // log('BARCODE: $json');
          // final couponId = jsonDecode(json)['couponId'];
          final couponModel = await scannerRepo.applyCoupon(couponId);

          final userModelResponse = UserRepository.getUserFromPreference()!;
          userModelResponse.data!.points =
              userModelResponse.data!.points! + couponModel.points!;
          // reelsBloc.state.userPoints = userModelResponse.data!.points!;
          UserRepository.addUserToPreference(userModelResponse);
          pointsBloc.add(PointsLoadEvent());
          profileBloc.add(ProfileLoadEvent());
          emit(ScannerCodeDetectedState(couponModel: couponModel));
        }
      } on CouponAlreadyAppliedException {
        emit(
          ScannerCodeDetectedState(
            couponModel: CouponModel(
              message: 'Coupon has already been applied',
              points: 0,
            ),
          ),
        );
      } on CouponNotFoundException {
        emit(
          ScannerCodeDetectedState(
            couponModel: CouponModel(
              message: 'Coupon not found',
              points: 0,
            ),
          ),
        );
      } catch (e) {
        log('EXCEPTION IN SCANNER BLOC: $e');
        emit(
          ScannerCodeDetectedState(
            couponModel: CouponModel(
              message: 'Something went wrong',
              points: 0,
            ),
          ),
        );
      }
    });

//====================Scanner Initial State Trigger Event====================//
    on<ScannerInitialStateTriggerEvent>((event, emit) {
      emit(ScannerInitialState());
    });
  }

//====================State Change Logger====================//
  @override
  void onChange(Change<ScannerState> change) {
    log('CURRENT STATE : ${change.currentState}');
    log('NEXT STATE: ${change.nextState}');
    super.onChange(change);
  }
}

final scannerBloc = ScannerBloc();
