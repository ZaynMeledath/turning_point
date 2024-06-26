// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turning_point/main.dart';
import 'package:turning_point/preferences/app_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:turning_point/service/Exception/api_exception.dart';
import 'package:turning_point/view/signin/sign_in_screen.dart';

enum RequestMethod {
  GET,
  POST,
  PATCH,
  PUT,
  DELETE,
}

class ApiService {
  String? token;

  Future sendRequest({
    required String url,
    required RequestMethod requestMethod,
    required dynamic data,
    required bool isTokenRequired,
  }) async {
    dynamic responseJson;
    if (isTokenRequired) {
      token = await AppPreferences.getValueShared('auth_token') ?? '';
    }
    try {
      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      Response response;
      switch (requestMethod) {
        case RequestMethod.GET:
          response = await http.get(Uri.parse(url), headers: headers);
          break;
        case RequestMethod.POST:
          final requestBody = data is String ? data : json.encode(data);
          response = await http.post(
            Uri.parse(url),
            headers: headers,
            body: requestBody,
          );
          break;
        case RequestMethod.PUT:
          final requestBody = data is String ? data : json.encode(data);
          response = await http.put(
            Uri.parse(url),
            headers: headers,
            body: requestBody,
          );
          break;
        case RequestMethod.PATCH:
          if (data is File) {
            final multiPartRequest = http.MultipartRequest(
              'PATCH',
              Uri.parse(url),
            );

            multiPartRequest.files
                .add(await MultipartFile.fromPath('image', data.path));
            multiPartRequest.headers.addAll(headers);

            final streamedResponse = await multiPartRequest.send();

            response = await Response.fromStream(streamedResponse);
          } else {
            final requestBody = data is String ? data : json.encode(data);

            response = await http.patch(
              Uri.parse(url),
              headers: headers,
              body: requestBody,
            );
          }

          break;
        case RequestMethod.DELETE:
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
    } on CustomException {
      rethrow;
    } on NotFoundException {
      rethrow;
    } on ProfileInactiveException {
      rethrow;
    } on BadRequestException {
      rethrow;
    } catch (e) {
      throw Exception(e);
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    final statusCode = response.statusCode;
    final responseJson = jsonDecode(response.body);

    switch (statusCode) {
      case 200:
        return responseJson;
      case 202:
        throw ProfileInactiveException(responseJson.toString());
      case 204:
        throw NoContentException(responseJson.toString());
      case 400:
        throw BadRequestException(responseJson);
      case 401:
        throw UnauthenticatedException(responseJson.toString());
      case 403:
        throw ForbiddenException(responseJson.toString());
      case 404:
        throw NotFoundException(responseJson.toString());
      case 500:
        throw ServerErrorException(responseJson.toString());
      case 700:
        throw CustomException(responseJson['message']);
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
