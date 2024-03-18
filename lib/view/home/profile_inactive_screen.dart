// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turning_point/bloc/auth/auth_bloc.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/view/home/home_screen.dart';

class ProfileInactiveScreen extends StatelessWidget {
  ProfileInactiveScreen({super.key});

  Future<void> handleRefresh() async {
    await UserRepository.getUserById(avoidGettingFromPreference: true);
    authBloc.add(AuthInitializeEvent());
  }

  dynamic closeDialogHandle;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState && closeDialogHandle == null) {
          // closeDialogHandle = showLoadingDialog(context: context);
        } else if (state is SignedInState) {
          if (closeDialogHandle != null) Navigator.pop(context);
          closeDialogHandle = null;
          Navigator.of(context).pushAndRemoveUntil(
            PageTransition(
              child: const HomeScreen(),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 750),
            ),
            (_) => false,
          );
        } else if (state is! AuthLoadingState && closeDialogHandle != null) {
          Navigator.pop(context);
          closeDialogHandle = null;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: screenSize.height * .066,
          backgroundColor: const Color.fromRGBO(0, 99, 255, 1),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Verification Pending...',
            style: GoogleFonts.inter(
              fontSize: screenSize.width * .042,
              fontWeight: FontWeight.w600,
              // color: const Color.fromRGBO(16, 24, 40, 1),
              color: Colors.white,
            ),
          ),
        ),
        body: RefreshIndicator.adaptive(
          onRefresh: () => handleRefresh(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: screenSize.height * .15),
                  Lottie.asset(
                    'assets/lottie/profile_inactive_animation.json',
                    width: screenSize.width * .6,
                  ),
                  SizedBox(height: screenSize.height * .018),
                  Text(
                    'Your Profile will be approved by the admin\nwithin the next 24 hours',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: screenSize.width * .04,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(16, 24, 40, 1),
                    ),
                  ),
                  SizedBox(height: screenSize.height * .15)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
