part of '../sign_up_screen.dart';

Widget signUpRadioButtonSegment({
  required String title,
  required bool isActive,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .01),
    child: Row(
      children: [
        customRadioButton(isActive: isActive),
        SizedBox(width: screenSize.width * .051),
        Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .036,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}
