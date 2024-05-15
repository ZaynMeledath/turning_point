import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      emit(ScannerCodeDetectingState());
      try {
        // final location = await LocationRepository.getCurrentLocation();
        final couponModel = await scannerRepo.applyCoupon(
          couponId: event.couponId,
          // location: location,
        );

        final userModelResponse = UserRepository.getUserFromPreference()!;
        userModelResponse.data!.points =
            userModelResponse.data!.points! + couponModel.points!;
        UserRepository.addUserToPreference(userModelResponse);
        profileBloc.add(ProfileLoadEvent());
        emit(ScannerCodeDetectedState(couponModel: couponModel));
      } on CouponAlreadyAppliedException {
        emit(
          ScannerCodeDetectedState(
            couponModel: CouponModel(
              message: 'Coupon has already been applied',
              points: 0,
            ),
          ),
        );
      } on LocationServiceException {
        return emit(
          ScannerCodeDetectedState(
            couponModel: CouponModel(
              message: 'Location Service Error',
              points: 0,
            ),
          ),
        );
      } on CouponNotFoundException {
        return emit(
          ScannerCodeDetectedState(
            couponModel: CouponModel(
              message: 'Coupon not found',
              points: 0,
            ),
          ),
        );
      } catch (e) {
        log('EXCEPTION IN SCANNER BLOC : $e');
        return emit(
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

//====================Scan Coupon Method====================//
  Future<void> scanCoupon() async {
    String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
      lineColor: "#ffffff",
      cancelButtonText: "",
      isShowFlashIcon: false,
      scanMode: ScanMode.QR,
    );

    if (barcodeScanResult.isNotEmpty && barcodeScanResult != '-1') {
      scannerBloc.add(ScannerCodeDetectEvent(couponId: barcodeScanResult));
    }
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
