import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/utils/screen_size.dart';
import 'package:turning_point/model/user_model.dart';
import 'package:turning_point/view/edit_profile/edit_profile_screen.dart';

Widget editProfilePictureSegment({
  required BuildContext context,
  required UserModel userModel,
}) {
  return Column(
    children: [
      const SizedBox(height: 4),
      Stack(
        children: [
//====================Profile Picture====================//
          Hero(
            tag: 'profile_picture',
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                PageTransition(
                  child: const ProfilePictureView(),
                  type: PageTransitionType.fade,
                ),
              ),
              child: CircleAvatar(
                radius: screenSize.height * .055,
                // backgroundColor: const Color(0xffe12826),
                backgroundColor: const Color.fromRGBO(225, 225, 225, .7),
                child: CircleAvatar(
                  radius: (screenSize.height * .055) - 3,
                  child: CircleAvatar(
                    radius: (screenSize.height * .055) - 4,
                    foregroundImage:
                        CachedNetworkImageProvider(userModel.image!),
                  ),
                ),
              ),
            ),
          ),

//====================Camera Icon Stack====================//
          Positioned(
            bottom: 0,
            right: 1,
            child: GestureDetector(
              onTap: () {
                profileBloc.add(ProfilePictureUpdateEvent());
              },
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
          ),
        ],
      ),
    ],
  );
}
