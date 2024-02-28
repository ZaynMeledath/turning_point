import 'package:turning_point/constants/constants.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/service/api/api_endpoints.dart';
import 'package:turning_point/service/api/api_service.dart';

class RedeemRepository {
//====================Redeem Bank Method====================//
  Future<void> redeemBank({
    required int points,
  }) async {
    try {
      final userModel = UserRepository.getUserFromPreference()!.data!;
      await ApiService().sendRequest(
        url: ApiEndpoints.redeemPoints,
        requestMethod: RequestMethod.POST,
        data: {
          'points': points,
          'type': TransferType.BANK,
          'transferDetails': {
            'accountName': userModel.bankDetails![0].accountName,
            'accountNo': userModel.bankDetails![0].accountNo,
            'ifsc': userModel.bankDetails![0].ifsc,
            'banktype': userModel.bankDetails![0].banktype,
          },
        },
        isTokenRequired: true,
      );
    } catch (e) {
      rethrow;
    }
  }

//====================Redeem UPI Method====================//
  Future<void> redeemUpi({
    required int points,
    required String upiId,
  }) async {
    try {
      await ApiService().sendRequest(
        url: ApiEndpoints.redeemPoints,
        requestMethod: RequestMethod.POST,
        data: {
          'points': points,
          'type': TransferType.UPI,
          'transferDetails': {
            'upiId': upiId,
          },
        },
        isTokenRequired: true,
      );
    } catch (e) {
      rethrow;
    }
  }

//====================Generate Coupon Method====================//
  Future<String> generateCoupon({required int points}) async {
    try {
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.generateCoupon,
        requestMethod: RequestMethod.POST,
        data: {
          'points': points,
        },
        isTokenRequired: true,
      );
      await UserRepository.getUserById(avoidGettingFromPreference: true);
      final String coupon = response['data']['name'].toString();
      return coupon;
    } catch (e) {
      throw Exception(e);
    }
  }
}
