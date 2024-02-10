import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turning_point/main.dart';
import 'package:turning_point/preferences/app_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:turning_point/service/api/api_exception.dart';
import 'package:turning_point/view/signin/sign_in_screen.dart';

class ApiService {
  String? token;

  Future sendRequest({
    required String url,
    required String requestMethod,
    required dynamic data,
    required bool isTokenRequired,
  }) async {
    dynamic responseJson;
    if (isTokenRequired) {
      token = await AppPreferences.getValueShared('auth_token') ?? '';
    }
    try {
      final headers = {
        // 'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      dynamic response;
      switch (requestMethod) {
        case 'GET':
          response = await http.get(Uri.parse(url), headers: headers);
          break;
        case 'POST':
          final requestBody = data is String ? data : json.encode(data);
          response = await http.post(
            Uri.parse(url),
            headers: headers,
            body: requestBody,
          );
          break;
        case 'PUT':
          final requestBody = data is String ? data : json.encode(data);
          response = await http.put(
            Uri.parse(url),
            headers: headers,
            body: requestBody,
          );
          break;
        case 'PATCH':
          final requestBody = data is String ? data : json.encode(data);
          response = await http.patch(
            Uri.parse(url),
            headers: headers,
            body: requestBody,
          );
          break;
        case 'DELETE':
          response = await http.delete(Uri.parse(url), headers: headers);
          break;
        default:
          throw ArgumentError('Invalid HTTP method: $requestMethod');
      }

      responseJson = returnResponse(response);
    } on TimeoutException {
      throw TimeoutException('Request timed out');
    } on FormatException {
      throw const FormatException('Response format is not valid');
    } on UnauthenticatedException {
      token = null;
      sendUserToLoginScreen();
    } on ServerErrorException {
      throw ServerErrorException('Our servers are currently busy');
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    final statusCode = response.statusCode;
    final responseJson = jsonDecode(response.body);

    switch (statusCode) {
      case 200:
        return responseJson;
      case 204:
        throw NoContentException(responseJson.toString());
      case 400:
        throw BadRequestException(responseJson.toString());
      case 401:
        throw UnauthenticatedException(responseJson.toString());
      case 403:
        throw ForbiddenException(responseJson.toString());
      case 404:
        throw NotFoundException(responseJson.toString());
      case 500:
        throw ServerErrorException(responseJson.toString());
      default:
        throw FetchDataException(
          'Error occurred while communicating with the server with status code $statusCode',
        );
    }
  }

  void sendUserToLoginScreen() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await GoogleSignIn().signOut();
    await firebaseAuth.signOut();
    await AppPreferences.clearSharedPreferences();
    globalNavigatorKey.currentState!.pushAndRemoveUntil(
      PageTransition(
        child: const SignInScreen(),
        type: PageTransitionType.leftToRight,
      ),
      (route) => false,
    );
  }
}
