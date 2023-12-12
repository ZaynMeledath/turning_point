import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget editProfilePictureSegment({
  required BuildContext context,
  required Size screenSize,
}) {
  return Column(
    children: [
      Stack(
        children: [
//====================Profile Picture====================//
          Hero(
            tag: 'profile_picture',
            child: CircleAvatar(
              radius: screenSize.height * .053,
              backgroundColor: const Color(0xffe12826),
              child: CircleAvatar(
                radius: (screenSize.height * .053) - 1,
                child: CircleAvatar(
                  radius: (screenSize.height * .053) - 2,
                  foregroundImage: const AssetImage('assets/images/avatar.jpg'),
                ),
              ),
            ),
          ),

//====================Camera Icon Stack====================//
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: screenSize.height * .017,
              child: Container(
                width: screenSize.height * .027,
                height: screenSize.height * .027,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(226, 41, 43, 1),
                      Color.fromRGBO(226, 41, 43, .4),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: screenSize.height * .019,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 3),
      Text(
        'Edit Picture',
        style: GoogleFonts.inter(
          fontSize: screenSize.width * .026,
        ),
      )
    ],
  );
}
