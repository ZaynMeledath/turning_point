import 'package:turning_point/model/user_model.dart';

abstract class AuthProvider {
  Future<void> initialize();
  UserModel? get currentUser;

  Future<UserModel> signIn();

  Future<void> signOut();

  Future<void> sendPhoneVerification();
}
