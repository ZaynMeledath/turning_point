import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/bloc/auth/auth_event.dart';
import 'package:turning_point/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(SignInState());
}
