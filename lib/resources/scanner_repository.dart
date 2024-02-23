import 'package:turning_point/model/coupon_model.dart';
import 'package:turning_point/service/Exception/scanner_exceptions.dart';
import 'package:turning_point/service/api/api_endpoints.dart';
import 'package:turning_point/service/api/api_exception.dart';
import 'package:turning_point/service/api/api_service.dart';

class ScannerRepository {
  Future<CouponModel> applyCoupon(String couponId) async {
    try {
      final response = await ApiService().sendRequest(
        url: '${ApiEndpoints.applyCoupon}/$couponId',
        requestMethod: RequestMethod.GET,
        data: null,
        isTokenRequired: true,
      );
      return CouponModel.fromJson(response);
    } on CustomException catch (e) {
      if (e.message == 'Coupon has already been applied') {
        throw CouponAlreadyAppliedException();
      } else if (e.message == 'Coupon not found') {
        throw CouponNotFoundException();
      } else {
        throw Exception(e);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}