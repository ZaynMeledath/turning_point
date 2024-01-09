import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
class UserModel {
  // final String? token;
  final String? email;
  // final int? status;

  final String id;

  final String phone;
  final bool isPhoneVerified;

  const UserModel({
    this.email,
    // this.token,
    // // this.status,

    required this.id,
    required this.phone,
    required this.isPhoneVerified,
  });

  factory UserModel.fromFirebase(User user) => UserModel(
        id: user.uid,
        email: user.email!,
        phone: user.phoneNumber!,
        isPhoneVerified: user.phoneNumber != null,
      );

  // factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
  //       // email: json['email'],
  //       token: json['token'],
  //       // id: json['id'],

  //       // phone: json['email'],
  //       // isPhoneVerified: json['isPhoneVerified'],
  //     );
}
