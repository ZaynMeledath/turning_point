import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show
        AuthCredential,
        FirebaseAuth,
        FirebaseAuthException,
        GoogleAuthProvider,
        User;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/service/auth/auth_exceptions.dart';
import 'package:turning_point/service/auth/auth_provider.dart';
import 'package:turning_point/firebase_options.dart';
import 'package:turning_point/model/user_model.dart';

class FirebaseAuthProvider implements AuthProvider {
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
  Future<User> signIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      log('Direct Token : ${googleAuth?.idToken}');

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
        return user;
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
  Future<void> sendPhoneVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }
}
