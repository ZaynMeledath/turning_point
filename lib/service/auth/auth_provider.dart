import 'package:turning_point/model/user_model.dart';

abstract class AuthProvider {
  Future<void> initialize();
  UserModelResponse? get currentUser;

  Future<UserModelResponse> signIn();

  Future<void> signOut();

  Future<void> sendPhoneVerification();
}
