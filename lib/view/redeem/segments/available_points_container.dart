import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/points/points_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/utils/screen_size.dart';

Widget availablePointsContainer() {
  return BlocBuilder<PointsBloc, PointsState>(
    builder: (context, pointsState) {
      final points = pointsState.points;
      return Container(
        width: double.infinity,
        // height: screenSize.width * .35,
        margin: EdgeInsets.only(
          left: realScreenSize.width * .07,
          right: realScreenSize.width * .07,
          top: screenSize.height * .02,
        ),
        padding: EdgeInsets.all(screenSize.width * .025),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.8),
          borderRadius: BorderRadius.circular(21),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 3),
              color: Colors.black.withOpacity(.1),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //====================Avatar Image====================//
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, profileState) {
                if (profileState.userModel != null &&
                    profileState.userModel!.image != null) {
                  return CircleAvatar(
                    radius: screenSize.width * .051,
                    foregroundImage: CachedNetworkImageProvider(
                        profileState.userModel!.image!),
                  );
                } else {
                  return CupertinoActivityIndicator(
                    radius: screenSize.width * .031,
                    color: const Color.fromRGBO(0, 99, 255, 1),
                  );
                }
              },
            ),

            //====================Title====================//
            SizedBox(height: screenSize.height * .01),
            Text(
              'Available Points to Redeem',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .028,
                color: const Color.fromRGBO(123, 123, 123, 1),
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: screenSize.height * .01),

            //====================Available Points====================//
            Text(
              '$points',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .092,
                color: const Color.fromRGBO(255, 176, 53, 1),
                fontWeight: FontWeight.w500,
                height: 1,
              ),
            ),
          ],
        ),
      );
    },
  );
}
