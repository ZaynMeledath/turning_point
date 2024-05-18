import 'dart:developer';

import 'package:turning_point/model/coupon_model.dart';
import 'package:turning_point/service/Exception/scanner_exceptions.dart';
import 'package:turning_point/service/api/api_endpoints.dart';
import 'package:turning_point/service/Exception/api_exception.dart';
import 'package:turning_point/service/api/api_service.dart';

class ScannerRepository {
  Future<CouponModel> applyCoupon({
    required String couponId,
    // required Position location,
  }) async {
    try {
      final response = await ApiService().sendRequest(
        url: '${ApiEndpoints.applyCoupon}/$couponId',
        requestMethod: RequestMethod.GET,
        data: null,
        // {
        //   'latitude': location.latitude,
        //   'longitude': location.longitude,
        // },
        isTokenRequired: true,
      );
      return CouponModel.fromJson(response);
    } on BadRequestException catch (e) {
      log(e.toString());
      throw CouponAlreadyAppliedException();
    } on NotFoundException {
      throw CouponNotFoundException();
    } catch (e) {
      throw Exception(e);
    }
  }
}
