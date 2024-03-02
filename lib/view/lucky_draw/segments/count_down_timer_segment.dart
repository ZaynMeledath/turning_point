part of '../lucky_draw_screen.dart';

//====================Whole Timer Segment====================//
Widget countDownTimerSegment({
  required String days,
  required String hours,
  required String minutes,
  required String seconds,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .041),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        countDownContainer(time: days, title: 'DAYS'),
        SizedBox(width: screenSize.width * .01),
        Text(
          ':',
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .084,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: screenSize.width * .01),
        countDownContainer(time: hours, title: 'HOURS'),
        SizedBox(width: screenSize.width * .01),
        Text(
          ':',
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .084,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: screenSize.width * .01),
        countDownContainer(time: minutes, title: 'MINUTES'),
        SizedBox(width: screenSize.width * .01),
        Text(
          ':',
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .084,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: screenSize.width * .01),
        countDownContainer(time: seconds, title: 'SECONDS'),
      ],
    ),
  );
}
