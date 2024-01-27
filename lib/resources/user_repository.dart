import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:turning_point/exceptions/user_exceptions.dart';
import 'package:turning_point/model/user_model.dart';
import 'package:turning_point/preferences/app_preferences.dart';
import 'package:turning_point/service/api/api_endpoints.dart';
import 'package:turning_point/service/api/api_service.dart';

class UserRepository {
//====================Decode JWT====================//
  static dynamic decodeJwt() {
    final token = AppPreferences.getValueShared('auth_token');
    final Map<String, dynamic> decodedData = JwtDecoder.decode(token);

    return decodedData;
  }

//====================Get User by ID====================//
  static Future<UserModelResponse>? getUserById() async {
    try {
      final id = decodeJwt()['userId'];
      final response = await ApiService().sendRequest(
        url: '${ApiEndpoints.getUser}/$id',
        requestMethod: 'GET',
        data: null,
        isTokenRequired: true,
      );
      AppPreferences.addSharedPreference(
        key: 'user_json',
        value: jsonEncode(response),
      );
      return UserModelResponse.fromJson(response);
    } catch (e) {
      throw CouldNotFetchUserFromApiException();
    }
  }

//====================Update User Profile====================//
  static Future<UserModelResponse?> updateUserProfile({
    required String name,
    required String phone,
    required String businessName,
    required String email,
  }) async {
    try {
      await ApiService().sendRequest(
        url: ApiEndpoints.updateUserProfile,
        requestMethod: 'PATCH',
        data: {
          "name": name,
          "phone": phone,
          "shopName": businessName,
          "email": email,
        },
        isTokenRequired: true,
      );
      final userModelResponse = await getUserById();
      return userModelResponse;
    } catch (e) {
      throw CouldNotUpdateUserException();
    }
  }

//====================Add User to SharedPreference====================//
  static void addUserToPreference(UserModelResponse userModelResponse) {
    AppPreferences.addSharedPreference(
      key: 'user_json',
      value: jsonEncode(userModelResponse),
    );
  }

//=====================Fetch and Decode userJson from SharedPreference====================//
  static UserModelResponse? getUserFromPreference() {
    final prefData = AppPreferences.getValueShared('user_json');
    if (prefData != null) {
      final userJson = jsonDecode(prefData);
      return UserModelResponse.fromJson(userJson);
    } else {
      return null;
    }
  }
}
