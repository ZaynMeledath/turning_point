import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/bloc/auth/auth_bloc.dart';
import 'package:turning_point/bloc/points/points_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart'
    show ProfileLoadEvent, profileBloc;
import 'package:turning_point/view/boarding/first_boarding_screen.dart';
import 'package:turning_point/view/home/home_screen.dart';
import 'package:turning_point/view/home/profile_inactive_screen.dart';
import 'package:turning_point/view/signin/who_is_signing_screen.dart';

class InitializeScreen extends StatelessWidget {
  final bool? shouldInitialize;
  const InitializeScreen({
    this.shouldInitialize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (shouldInitialize != false) {
      authBloc.add(AuthInitializeEvent());
    }
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is ProfileInactiveState) {
          return ProfileInactiveScreen();
        } else if (state is DirectSignedInState) {
          profileBloc.add(ProfileLoadEvent(avoidGettingFromPreference: true));
          pointsBloc.add(PointsLoadEvent(avoidGettingUserFromPreference: true));
          return const HomeScreen();
        } else if (state is WhoIsSigningState) {
          return const WhoIsSigningScreen();
        } else {
          return const FirstBoardingScreen();
        }
      },
    );
  }
}
