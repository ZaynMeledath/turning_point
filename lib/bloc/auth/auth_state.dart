part of 'auth_bloc.dart';

sealed class AuthState {}

class SignedOutState extends AuthState {}

class GoogleSignInSucess extends AuthState {}

class SignOutState extends AuthState {}
