import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:turning_point/model/user_model.dart';

abstract class AuthProvider {
  Future<void> initialize();
  UserModelResponse? get currentUser;

  Future<User> signIn();

  Future<void> signOut();

  Future<void> sendPhoneVerification();
}
