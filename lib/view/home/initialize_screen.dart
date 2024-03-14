import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/bloc/auth/auth_bloc.dart';
import 'package:turning_point/helper/widget/custom_loading.dart';
import 'package:turning_point/view/home/home_screen.dart';
import 'package:turning_point/view/home/profile_inactive_screen.dart';
import 'package:turning_point/view/signin/who_is_signing_screen.dart';

class InitializeScreen extends StatelessWidget {
  const InitializeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    authBloc.add(AuthInitializeEvent());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is ProfileInactiveState) {
          return const ProfileInactiveScreen();
        } else if (state is SignedInState) {
          return const HomeScreen();
        } else if (state is WhoIsSigningState) {
          return const WhoIsSigningScreen();
        } else {
          return spinningLinesLoading();
        }
      },
    );
  }
}
