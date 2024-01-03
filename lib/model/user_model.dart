import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
class UserModel {
  final String id;
  final String email;
  final bool isPhoneVerified;
  const UserModel({
    required this.id,
    required this.email,
    required this.isPhoneVerified,
  });

  factory UserModel.fromFirebase(User user) => UserModel(
        id: user.uid,
        email: user.email!,
        isPhoneVerified: user.phoneNumber != null,
      );
}
