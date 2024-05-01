import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:turning_point/constants/constants.dart';
import 'package:turning_point/exceptions/user_exceptions.dart';
import 'package:turning_point/model/contractor_model.dart';
import 'package:turning_point/model/user_model.dart';
import 'package:turning_point/preferences/app_preferences.dart';
import 'package:turning_point/service/Exception/api_exception.dart';
import 'package:turning_point/service/api/api_endpoints.dart';
import 'package:turning_point/service/api/api_service.dart';
import 'package:turning_point/service/auth/auth_exceptions.dart';
import 'package:turning_point/service/auth/auth_service.dart';
import 'package:turning_point/service/auth/firebase_auth_provider.dart';

class UserRepository {
//====================Decode JWT====================//
  static dynamic decodeJwt() {
    final token = AppPreferences.getValueShared('auth_token');
    final Map<String, dynamic> decodedData = JwtDecoder.decode(token);

    return decodedData;
  }

//====================User Sign In====================//
  static Future<bool> userSignIn({
    required String token,
    required String fcmToken,
  }) async {
    try {
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.googleSignIn,
        requestMethod: RequestMethod.POST,
        data: {
          "idToken": token,
          "fcmToken": fcmToken,
        },
        isTokenRequired: false,
      );

      await AppPreferences.init();
      AppPreferences.addSharedPreference(
        key: 'auth_token',
        value: response["token"],
      );

      return response['status'];
    } catch (e) {
      log('EXCEPTION IN USER SIGN IN : $e');
      throw CouldNotSignInUserAuthException(errorMessage: e.toString());
    }
  }

//====================Check Phone Number====================//
  static Future<bool> checkPhoneNumber(String phone) async {
    final response = await ApiService().sendRequest(
      url: ApiEndpoints.checkPhoneNumber,
      requestMethod: RequestMethod.POST,
      data: {
        'phone': phone,
      },
      isTokenRequired: false,
    );
    final status = response['exists'];
    return status;
  }

//====================User Sign Up====================//
  static Future<bool> userSignUp({
    required String phone,
    ContractorModel? contractor,
    String? businessName,
    String? token,
    String? fcmToken,
    Position? location,
    String? refCode,
  }) async {
    try {
      final authService = AuthService.firebase();
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
              "phone": contractor.phone,
            },
          "idToken": token,
          "fcmToken": fcmToken,
          "refCode": refCode,
          if (location != null)
            "address": {
              "coordinates": [location.latitude, location.longitude]
            },
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
      rethrow;
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
      if (!response['data']['image'].startsWith('http')) {
        response['data']['image'] =
            '${ApiEndpoints.uploads}/${response['data']['image']}';
      }

      AppPreferences.init();
      AppPreferences.removeFromPreference('user_json');
      AppPreferences.addSharedPreference(
        key: 'user_json',
        value: jsonEncode(response),
      );

      final userModelResponse = UserModelResponse.fromJson(response);
      return userModelResponse;
    } catch (e) {
      rethrow;
    }
  }

//====================Update User Online Status====================//
  static void updateUserOnlineStatus({required bool isOnline}) async {
    try {
      await ApiService().sendRequest(
        url: ApiEndpoints.updateUserOnlineStatus,
        requestMethod: RequestMethod.PATCH,
        data: {'isOnline': isOnline},
        isTokenRequired: true,
      );
    } catch (e) {
      log('Exception in UpdateUserOnlineStatus');
      throw Exception(e);
    }
  }

//====================Get All Contractors====================//
  static Future<ContractorModelResponse> getContractors() async {
    try {
      final email = FirebaseAuthProvider().currentUser!.email;
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.getContractors,
        requestMethod: RequestMethod.GET,
        data: {"email": email},
        isTokenRequired: false,
      );

      return ContractorModelResponse.fromJson(response);
    } catch (e) {
      throw Exception(e);
    }
  }

//====================Update User Profile====================//
  static Future<UserModelResponse> updateUserProfile({
    required UserModel userModel,
  }) async {
    try {
      await ApiService().sendRequest(
        url: ApiEndpoints.updateUserProfile,
        requestMethod: RequestMethod.PATCH,
        data: userModel.toJson(),
        isTokenRequired: true,
      );
      final userModelResponse =
          await getUserById(avoidGettingFromPreference: true);
      return userModelResponse!;
    } on ProfileInactiveException {
      rethrow;
    } catch (e) {
      log('EXCEPTION IN UPDATE USER PROFILE : $e');
      throw CouldNotUpdateUserException(message: e.toString());
    }
  }

//====================Update User Profile Image====================//
  static Future<UserModelResponse> updateProfileImage(
      String imageString) async {
    try {
      await ApiService().sendRequest(
        url: ApiEndpoints.updateProfileImage,
        requestMethod: RequestMethod.PATCH,
        data: {
          'image': imageString,
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
  static Future<Map<String, File>?> fetchAndConvertImageToBase64({
    bool? isSelfie,
    bool? isId,
  }) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(
        source: isSelfie == true ? ImageSource.camera : ImageSource.gallery,
        preferredCameraDevice: CameraDevice.front,
      );

      if (image != null) {
        CroppedFile? croppedImage = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            isId == true || isSelfie == true
                ? CropAspectRatioPreset.original
                : CropAspectRatioPreset.square,
          ],
          cropStyle: isId == true || isSelfie == true
              ? CropStyle.rectangle
              : CropStyle.circle,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.black,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: isId == true || isSelfie == true
                  ? CropAspectRatioPreset.original
                  : CropAspectRatioPreset.square,
              lockAspectRatio: false,
              activeControlsWidgetColor: Colors.blue,
            ),
            IOSUiSettings(
              title: 'Cropper',
            ),
          ],
        );
        if (croppedImage != null) {
          final imageFile = File(croppedImage.path);
          final base64Image = base64Encode(await croppedImage.readAsBytes());
          final result =
              'furnipart/${image.path.split('/').last};base64,$base64Image';

          //Image Map is used for KYC Bloc
          return {result: imageFile};
        }
      }
      return null;
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
