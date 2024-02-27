import 'package:turning_point/constants/constants.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/service/api/api_endpoints.dart';
import 'package:turning_point/service/api/api_service.dart';

class RedeemRepository {
//====================Redeem Method====================//
  Future<void> redeem({
    required int points,
    required String transferType,
    String? upiId,
  }) async {
    try {
      final userModel = UserRepository.getUserFromPreference()!.data!;
      await ApiService().sendRequest(
        url: ApiEndpoints.redeemPoints,
        requestMethod: RequestMethod.POST,
        data: {
          'points': points,
          'type': transferType,
          'transferDetails': {
            'accountName': userModel.bankDetails![0].accountName,
            'accountNo': userModel.bankDetails![0].accountNo,
            'ifsc': userModel.bankDetails![0].ifsc,
            'banktype': userModel.bankDetails![0].banktype,
            if (transferType == TransferType.UPI) 'upiId': upiId,
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
