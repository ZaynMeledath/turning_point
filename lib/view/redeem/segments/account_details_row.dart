part of '../redeem_screen.dart';

Widget accountDetailsRow({
  required String key,
  required String value,
  required double spacing,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        '$key :',
        style: GoogleFonts.roboto(
          fontSize: screenSize.width * .036,
        ),
      ),
      SizedBox(width: spacing),
      Text(
        value,
        style: GoogleFonts.roboto(
          fontSize: screenSize.width * .036,
        ),
      ),
    ],
  );
}
