import 'package:turning_point/service/auth/auth_provider.dart';
import 'package:turning_point/service/auth/firebase_auth_provider.dart';
import 'package:turning_point/model/user_model.dart';

class AuthService implements CustomAuthProvider {
  final CustomAuthProvider provider;
  AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<void> initialize() => provider.initialize();

  @override
  UserModelResponse? get currentUser => provider.currentUser;

  @override
  Future<String> signIn() => provider.signIn();

  @override
  Future<void> signOut() => provider.signOut();

  @override
  Future<void> sendPhoneVerification() => provider.sendPhoneVerification();
}
