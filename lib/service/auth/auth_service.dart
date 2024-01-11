import 'package:turning_point/service/auth/auth_provider.dart';
import 'package:turning_point/service/auth/firebase_auth_provider.dart';
import 'package:turning_point/model/user_model.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<void> initialize() => provider.initialize();

  @override
  UserModel? get currentUser => provider.currentUser;

  @override
  Future<UserModel> signIn() => provider.signIn();

  @override
  Future<void> signOut() => provider.signOut();

  @override
  Future<void> sendPhoneVerification() => provider.sendPhoneVerification();
}
