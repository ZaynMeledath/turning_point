part of 'auth_bloc.dart';

sealed class AuthEvent {}

class SignInButtonPressedEvent extends AuthEvent {}

class SignInEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}
