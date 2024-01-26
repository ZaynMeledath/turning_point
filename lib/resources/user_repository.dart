import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
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
  static Future<UserModel>? getUserById() async {
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
    return UserModel.fromJson(response);
  }

  static void addUserToPreference(UserModel userModel) {
    AppPreferences.addSharedPreference(
      key: 'user_json',
      value: jsonEncode(userModel),
    );
  }

//=====================Fetch and Decode userJson from SharedPreference====================//
  static UserModel? getUserFromPreference() {
    final prefData = AppPreferences.getValueShared('user_json');
    if (prefData != null) {
      final userJson = jsonDecode(prefData);
      return UserModel.fromJson(userJson);
    } else {
      return null;
    }
  }
}
