// part of 'package:turning_point/lib/login/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';

Widget signUpTextField({
  required TextEditingController controller,
  required String title,
}) {
  return Center(
    child: SizedBox(
      height: screenSize.height * .056 + (screenSize.height * .019) / 2,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
//====================TextField Container====================//
          Container(
            width: double.infinity,
            height: screenSize.height * .056,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 1,
                color: const Color.fromRGBO(142, 142, 142, 1),
              ),
            ),
//====================TextField====================//
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
//====================floating TextField Title====================//
          Positioned(
            top: 0,
            left: screenSize.width * .05,
            child: Container(
              height: screenSize.height * .019,
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * .028),
              color: Colors.white,
              child: Center(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: screenSize.width * .031,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
