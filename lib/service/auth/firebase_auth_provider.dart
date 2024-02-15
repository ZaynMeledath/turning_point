import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/service/auth/auth_exceptions.dart';
import 'package:turning_point/service/auth/auth_provider.dart';
import 'package:turning_point/firebase_options.dart';
import 'package:turning_point/model/user_model.dart';

class FirebaseAuthProvider implements CustomAuthProvider {
  static String verifyId = '';
  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  @override
  UserModelResponse? get currentUser {
    final user = UserRepository.getUserById(avoidGettingFromPreference: false);
    if (user is String) {
      return null;
    } else {
      return null;
    }
  }

  @override
  Future<String> signIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

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
        final token = await FirebaseAuth.instance.currentUser!.getIdToken();
        log('TOKEN : $token');
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
        throw GenericAuthException();
      }
    } catch (e) {
      log('EXCEPTION IN GOOGLE SIGN IN FIREBASE: $e');
      throw GenericAuthException();
    }
  }

  @override
  Future<void> signOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> sendPhoneVerification({required String phone}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+91$phone',
          codeSent: (verificationId, forceResendingToken) {
            verifyId = verificationId;
          },
          verificationCompleted: (phoneAuthCredential) {},
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
  Future<void> verifyOtp({
    required String verificationId,
    required String otp,
  }) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    log('LOGGED IN : $userCredential');
  }
}
