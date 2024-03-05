import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class CustomAuthProvider {
  Future<void> initialize();
  User? get currentUser;

  Future<String> signIn();

  Future<void> signOut();

  Future<void> sendPhoneVerification({
    required String phone,
    required TextEditingController otpController,
  });

  Future<String?> verifyOtp({
    required String verificationId,
    required String otp,
  });

  Future<String?> getFcmToken();
}
