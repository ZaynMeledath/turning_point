import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/points/points_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';

Widget availablePointsContainer({required Size screenSize}) {
  return BlocBuilder<PointsBloc, PointsState>(
    builder: (context, pointsState) {
      final points = pointsState.points;
      return Container(
        width: double.infinity,
        // height: screenSize.width * .35,
        margin: EdgeInsets.only(
          left: screenSize.width * .07,
          right: screenSize.width * .07,
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
                return CircleAvatar(
                  foregroundImage: NetworkImage(profileState.userModel!.image!),
                );
              },
            ),

            //====================Title====================//
            SizedBox(height: screenSize.height * .005),
            Text(
              'Available Points to Redeem',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .028,
                color: const Color.fromRGBO(123, 123, 123, 1),
                fontWeight: FontWeight.w500,
              ),
            ),

            //====================Available Points====================//
            Text(
              '$points',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .092,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    },
  );
}
