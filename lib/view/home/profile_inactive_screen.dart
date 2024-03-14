import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point/bloc/auth/auth_bloc.dart';
import 'package:turning_point/helper/screen_size.dart';

class ProfileInactiveScreen extends StatelessWidget {
  const ProfileInactiveScreen({super.key});

  Future<void> handleRefresh() async {
    authBloc.add(AuthInitializeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 99, 255, 1),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Verification Pending',
          style: GoogleFonts.inter(
            fontSize: screenSize.width * .045,
            fontWeight: FontWeight.w600,
            // color: const Color.fromRGBO(16, 24, 40, 1),
            color: Colors.white,
          ),
        ),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () => handleRefresh(),
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
                  fontSize: screenSize.width * .041,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(16, 24, 40, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
