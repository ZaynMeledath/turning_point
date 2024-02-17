import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';

class ProfileInactiveScreen extends StatelessWidget {
  const ProfileInactiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        children: [
          Image.asset(
            'assets/icons/kyc_declined_icon.png',
            width: screenSize.width * .26,
          ),
          SizedBox(height: screenSize.height * .018),
          Text(
            'Profile Inactive',
            style: GoogleFonts.inter(
              fontSize: screenSize.width * .048,
              fontWeight: FontWeight.w600,
              color: const Color.fromRGBO(16, 24, 40, 1),
            ),
          ),
        ],
      ),
    );
  }
}
