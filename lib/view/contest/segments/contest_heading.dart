part of '../contest_screen.dart';

Widget contestHeading() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .051),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'CONTESTS',
          style: GoogleFonts.poppins(
            fontSize: screenSize.width * .051,
            fontWeight: FontWeight.w700,
            color: const Color.fromRGBO(83, 83, 83, 1),
          ),
        ),
      ],
    ),
  );
}
