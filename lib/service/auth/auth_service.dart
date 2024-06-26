import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show TextEditingController;
import 'package:turning_point/service/auth/auth_provider.dart';
import 'package:turning_point/service/auth/firebase_auth_provider.dart';

class AuthService implements CustomAuthProvider {
  final CustomAuthProvider provider;
  AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<void> initialize() => provider.initialize();

  @override
  User? get currentUser => provider.currentUser;

  @override
  Future<String> signIn() => provider.signIn();

  @override
  Future<void> signOut() => provider.signOut();

  @override
  Future<void> sendPhoneVerification({
    required String phone,
    required TextEditingController otpController,
  }) =>
      provider.sendPhoneVerification(
        phone: phone,
        otpController: otpController,
      );

  @override
  Future<String?> verifyOtp(
          {required String verificationId, required String otp}) =>
      provider.verifyOtp(
        verificationId: verificationId,
        otp: otp,
      );

  @override
  Future<String?> getFcmToken() => provider.getFcmToken();
}
