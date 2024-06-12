import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/utils/screen_size.dart';

Widget profileLoadError({
  required ProfileLoadErrorState profileState,
  bool? shouldIncludeLottie,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      shouldIncludeLottie != false
          ? Lottie.asset(
              'assets/lottie/no_internet_animation.json',
              width: screenSize.width * .5,
            )
          : const SizedBox(),
      SizedBox(height: screenSize.height * .01),
      Text(
        'Something went wrong',
        style: GoogleFonts.roboto(
          fontSize: screenSize.width * .035,
          fontWeight: FontWeight.w500,
          color: const Color.fromRGBO(18, 18, 18, 1),
        ),
      ),
      SizedBox(height: screenSize.height * .01),
      Text(
        'Check your internet connection\nor try again later',
        textAlign: TextAlign.center,
        style: GoogleFonts.roboto(
          fontSize: screenSize.width * .031,
          color: const Color.fromRGBO(18, 18, 18, 18),
        ),
      ),
      SizedBox(height: screenSize.height * .02),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              profileBloc.add(
                ProfileErrorStateReloadEvent(),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * .035,
                vertical: screenSize.width * .01,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color.fromRGBO(18, 18, 18, 1),
                ),
              ),
              child: Text(
                'Refresh',
                style: GoogleFonts.roboto(
                  fontSize: screenSize.width * .035,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(18, 18, 18, 1),
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: screenSize.height * .005),
      SizedBox(
        height: screenSize.height * .035,
        child: Visibility(
          visible: profileState.isLoading,
          child: CupertinoActivityIndicator(
            radius: screenSize.width * .026,
          ),
        ),
      ),
    ],
  );
}
