import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:turning_point/model/coupon_model.dart';
import 'package:turning_point/resources/scanner_repository.dart';
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
          final json = barcodes[0].rawValue!;
          log(json);
          final couponId = jsonDecode(json)['couponId'];
          final couponModel = await scannerRepo.applyCoupon(couponId);
          emit(ScannerCodeDetectedState(couponModel: couponModel));
        }
      } on CouponAlreadyAppliedException {
        emit(
          ScannerCodeDetectedState(
            couponModel: CouponModel(
              message: 'Coupon already applied',
              points: 0,
              success: true,
            ),
          ),
        );
      } catch (e) {
        emit(
          ScannerCodeDetectedState(
            couponModel: CouponModel(
              message: 'Something went wrong',
              points: 0,
              success: false,
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
