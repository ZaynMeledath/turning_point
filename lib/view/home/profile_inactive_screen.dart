// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turning_point/bloc/auth/auth_bloc.dart';
import 'package:turning_point/dialog/show_loading_dialog.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/view/home/home_screen.dart';

class ProfileInactiveScreen extends StatelessWidget {
  ProfileInactiveScreen({super.key});

  Future<void> _handleRefresh() async {
    await UserRepository.getUserById(avoidGettingFromPreference: true);
    authBloc.add(AuthInitializeEvent());
  }

  dynamic closeDialogHandle;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          showLoadingDialog(context: context);
        } else if (state is DirectSignedInState) {
          Navigator.pop(context);
          closeDialogHandle = null;
          Navigator.of(context).pushAndRemoveUntil(
            PageTransition(
              child: const HomeScreen(),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 750),
            ),
            (_) => false,
          );
        } else {
          Navigator.pop(context);
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
        body: LiquidPullToRefresh(
          height: 70,
          animSpeedFactor: 1.5,
          showChildOpacityTransition: false,
          color: const Color.fromRGBO(89, 165, 255, 1),
          backgroundColor: Colors.white,
          onRefresh: () => _handleRefresh(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Center(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * .04),
                child: Column(
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
      ),
    );
  }
}
