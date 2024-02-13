import 'package:turning_point/model/user_model.dart';

abstract class CustomAuthProvider {
  Future<void> initialize();
  UserModelResponse? get currentUser;

  Future<String> signIn();

  Future<void> signOut();

  Future<void> sendPhoneVerification();
}
