import 'dart:convert';
import 'dart:developer';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:turning_point/constants/constants.dart';
import 'package:turning_point/exceptions/user_exceptions.dart';
import 'package:turning_point/model/contractor_model.dart';
import 'package:turning_point/model/user_model.dart';
import 'package:turning_point/preferences/app_preferences.dart';
import 'package:turning_point/service/api/api_endpoints.dart';
import 'package:turning_point/service/api/api_service.dart';
import 'package:turning_point/service/auth/auth_exceptions.dart';
import 'package:turning_point/service/auth/auth_service.dart';

class UserRepository {
//====================Decode JWT====================//
  static dynamic decodeJwt() {
    final token = AppPreferences.getValueShared('auth_token');
    final Map<String, dynamic> decodedData = JwtDecoder.decode(token);

    return decodedData;
  }

  static Future<bool> userSignIn(String token) async {
    try {
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.googleSignIn,
        requestMethod: RequestMethod.POST,
        data: {"idToken": token},
        isTokenRequired: false,
      );

      log('RESPONSE: $response');

      await AppPreferences.init();
      AppPreferences.addSharedPreference(
        key: 'auth_token',
        value: response["token"],
      );

      return response['status'];
    } catch (e) {
      log('EXCEPTION IN USER SIGN IN : $e');
      throw CouldNotSignInUserAuthException();
    }
  }

  static Future<bool> userSignUp({
    required String phone,
    ContractorModel? contractor,
    String? businessName,
    String? token,
  }) async {
    try {
      final authService = AuthService.firebase();
      log('UID : ${authService.currentUser!.uid}');
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.register,
        data: {
          "uid": authService.currentUser!.uid,
          "phone": phone,
          "role": businessName != null ? Role.CONTRACTOR : Role.CARPENTER,
          if (businessName != null) "businessName": businessName,
          if (contractor != null)
            "contractor": {
              "name": contractor.name,
              "businessName": contractor.businessName,
            },
          "idToken": token,
        },
        requestMethod: RequestMethod.POST,
        isTokenRequired: false,
      );

      await AppPreferences.init();
      AppPreferences.removeFromPreference('auth_token');
      AppPreferences.addSharedPreference(
        key: 'auth_token',
        value: response["token"],
      );

      log('AUTH TOKEN FROM SERVER: ${response['token']}');

      if (response['token'] == null) {
        throw Exception('Token is Null');
      }
      if (response['status']) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('EXCEPTION IN USER SIGNUP: $e');
      throw CouldNotSignUpUserAuthException;
    }
  }

//====================Get User by ID====================//
  static Future<UserModelResponse?> getUserById({
    required bool avoidGettingFromPreference,
  }) async {
    try {
      if (!avoidGettingFromPreference) {
        final userModelResponse = getUserFromPreference();
        if (userModelResponse != null) {
          return userModelResponse;
        }
      }
      final id = decodeJwt()['userId'];
      final response = await ApiService().sendRequest(
        url: '${ApiEndpoints.getUser}/$id',
        requestMethod: RequestMethod.GET,
        data: null,
        isTokenRequired: true,
      );

//---google account image will have the whole url, but image from server will only have the image name---//
      if (!response['data']['image'].startsWith('https')) {
        response['data']['image'] =
            '${ApiEndpoints.uploads}/${response['data']['image']}';
      }

      AppPreferences.init();
      AppPreferences.removeFromPreference('user_json');
      AppPreferences.addSharedPreference(
        key: 'user_json',
        value: jsonEncode(response),
      );

      log('GET USER BY ID FUNCTION: $response');
      final userModelResponse = UserModelResponse.fromJson(response);
      return userModelResponse;
    } catch (e) {
      log('EXCEPTION IN GET USER BY ID : $e');
      rethrow;
    }
  }

//====================Get All Contractors====================//
  static Future<ContractorModelResponse> getContractors() async {
    final response = await ApiService().sendRequest(
      url: ApiEndpoints.getContractors,
      requestMethod: RequestMethod.GET,
      data: null,
      isTokenRequired: true,
    );

    return ContractorModelResponse.fromJson(response);
  }

//====================Update User Profile====================//
  static Future<UserModelResponse> updateUserProfile({
    required UserModel userModel,
  }) async {
    try {
      log('UPDATING');
      await ApiService().sendRequest(
        url: ApiEndpoints.updateUserProfile,
        requestMethod: RequestMethod.PATCH,
        data: {
          "name": userModel.name,
          "phone": userModel.phone,
          "businessName": userModel.businessName,
          "address": userModel.address,
          "email": userModel.email,
          "pincode": userModel.pincode,
          "role": userModel.role,
          "contractor": {
            "name": userModel.contractor?.name,
            "businessName": userModel.contractor?.businessName,
          },
          if (userModel.bankDetails != null &&
              userModel.bankDetails!.isNotEmpty)
            "bankDetails": {
              "type": userModel.bankDetails![0].banktype,
              "accountName": userModel.bankDetails![0].accountName,
              "accountNo": userModel.bankDetails![0].accountNo,
              "ifsc": userModel.bankDetails![0].ifsc,
            },
        },
        isTokenRequired: true,
      );
      final userModelResponse =
          await getUserById(avoidGettingFromPreference: true);
      return userModelResponse!;
    } catch (e) {
      log('EXCEPTION IN UPDATE USER PROFILE : $e');
      throw CouldNotUpdateUserException();
    }
  }

//====================Update User Profile Image====================//
  static Future<UserModelResponse> updateProfileImage(
      String imageString) async {
    try {
      log('UPDATING');
      await ApiService().sendRequest(
        url: ApiEndpoints.updateProfileImage,
        requestMethod: RequestMethod.PATCH,
        data: {
          "image": imageString,
        },
        isTokenRequired: true,
      );
      final userModelResponse =
          await getUserById(avoidGettingFromPreference: true);

      return userModelResponse!;
    } catch (e) {
      log('EXCEPTION IN UPDATE PROFILE IMAGE : $e');
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
    if (prefData != null && prefData.isNotEmpty) {
      final userJson = jsonDecode(prefData);
      return UserModelResponse.fromJson(userJson);
    } else {
      return null;
    }
  }
}
