import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart' show TextEditingController;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:turning_point/service/auth/auth_exceptions.dart';
import 'package:turning_point/service/auth/auth_provider.dart';
import 'package:turning_point/firebase_options.dart';

class FirebaseAuthProvider implements CustomAuthProvider {
  static String verifyId = '';
  static int? forceResendToken;
  GoogleSignInAccount? googleUser;
  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  @override
  User? get currentUser => FirebaseAuth.instance.currentUser;

  @override
  Future<String> signIn() async {
    try {
      googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      log('CREDENTIALS: $credential');

      // Once signed in, return the UserCredential
      final result =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = result.user;

      log('USER: $user');
      if (user != null) {
        final token = await currentUser!.getIdToken();
        return token!;
      } else {
        log('EXCEPTION');
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'network-request-failed') {
        throw NetworkRequestFailedAuthException();
      } else {
        log('Exception in Google Sign In : $e');
        throw GenericAuthException();
      }
    } catch (e) {
      log('EXCEPTION IN GOOGLE SIGN IN FIREBASE: $e');
      throw GenericAuthException();
    }
  }

  @override
  Future<void> signOut() async {
    if (currentUser != null) {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> sendPhoneVerification({
    required String phone,
    required TextEditingController otpController,
  }) async {
    try {
      if (currentUser != null) {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+91$phone',
          forceResendingToken: forceResendToken,
          codeSent: (verificationId, forceResendingToken) {
            verifyId = verificationId;
            forceResendToken = forceResendingToken;
          },
          verificationCompleted: (phoneAuthCredential) {
            otpController.text = phoneAuthCredential.smsCode ?? '';
          },
          verificationFailed: (error) {
            throw error;
          },
          codeAutoRetrievalTimeout: (verificationId) {},
        );
      } else {
        throw UserNotLoggedInAuthException();
      }
    } catch (e) {
      log('EXCEPTION IN PHONE VERIFICATION : $e');
      throw Exception(e);
    }
  }

  @override
  Future<String?> getFcmToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      return token;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String?> verifyOtp({
    required String verificationId,
    required String otp,
  }) async {
    try {
      // Create a new credential
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      //Sign in using the credential
      await FirebaseAuth.instance.signInWithCredential(credential);

//-----Automatic Sign in with google again to set the google account as current user-----//

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final AuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(googleCredential);
      final token = await currentUser!.getIdToken();
      if (token != null) {
        return token;
      } else {
        log('COULD NOT FETCH ID TOKEN AUTH EXCEPTION');
        throw CouldNotFetchIdTokenAuthException();
      }
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      log('EXCEPTION IN VERIFY OTP FUNCTION: $e');
      throw Exception(e);
    }
  }
}
