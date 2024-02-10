import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:turning_point/exceptions/user_exceptions.dart';
import 'package:turning_point/model/user_model.dart';
import 'package:turning_point/preferences/app_preferences.dart';
import 'package:turning_point/service/api/api_endpoints.dart';
import 'package:turning_point/service/api/api_service.dart';
import 'package:turning_point/service/auth/auth_exceptions.dart';

class UserRepository {
//====================Decode JWT====================//
  static dynamic decodeJwt() {
    final token = AppPreferences.getValueShared('auth_token');
    final Map<String, dynamic> decodedData = JwtDecoder.decode(token);

    return decodedData;
  }

  static Future<bool> userSignUp({required String mobileNumber}) async {
    try {
      final decodedResponse = await ApiService().sendRequest(
        url: ApiEndpoints.login,
        data: {"phone": mobileNumber},
        requestMethod: 'POST',
        isTokenRequired: false,
      );

      await AppPreferences.init();
      AppPreferences.addSharedPreference(
        key: 'auth_token',
        value: decodedResponse["token"],
      );
      if (decodedResponse['success']) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw CouldNotSignUpUserAuthException;
    }
  }

//====================Get User by ID====================//
  static Future<UserModelResponse?> getUserById() async {
    try {
      final userModelResponse = getUserFromPreference();
      if (userModelResponse != null) {
        return userModelResponse;
      }
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
    required UserModel userModel,
    required bool isKyc,
  }) async {
    try {
      await ApiService().sendRequest(
        url: ApiEndpoints.updateUserProfile,
        requestMethod: 'PATCH',
        data: {
          "name": userModel.name,
          "phone": userModel.phone,
          "shopName": userModel.shopName,
          "email": userModel.email,
          "pincode": userModel.pincode,
          "bankDetails": {
            "type": userModel.bankDetails![0].banktype,
            "accountName": userModel.bankDetails![0].accountName,
            "accountNo": userModel.bankDetails![0].accountNo,
            "ifsc": userModel.bankDetails![0].ifsc,
          },
        },
        isTokenRequired: true,
      );
      final userModelResponse = await getUserById();
      return userModelResponse;
    } catch (e) {
      throw CouldNotUpdateUserException();
    }
  }

//====================Update User Profile Image====================//
  static Future updateProfileImage(String imageString) async {
    try {
      await ApiService().sendRequest(
        url: ApiEndpoints.updateProfileImage,
        requestMethod: 'PATCH',
        data: {
          "image": imageString,
        },
        isTokenRequired: true,
      );
    } catch (_) {
      throw CouldNotUpdateUserProfileImageException();
    }
  }

//====================Get User Profile Image from Storage====================//
  static Future<String?> fetchImageFromStorage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final base64Image = base64Encode(await image.readAsBytes());
        final result =
            'furnipart/${image.path.split('/').last};base64,$base64Image';
        return result;
      } else {
        return null;
      }
    } catch (_) {
      throw CouldNotFetchImageFromStorageException();
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
