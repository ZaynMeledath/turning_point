part of '../lucky_draw_screen.dart';

Widget countDownContainer({
  required String time,
  required String title,
}) {
  return Container(
    width: screenSize.width * .195,
    height: screenSize.width * .22,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: const Color.fromRGBO(255, 255, 255, .9),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
//====================Time Container====================//
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(8),
              ),
            ),
            child: Center(
              child: Text(
                time,
                style: GoogleFonts.roboto(
                  fontSize: screenSize.width * .084,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),

//====================Title Container (Days/Hours/Minutes/Seconds)====================//
        Container(
          height: screenSize.width * .062,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(8),
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .036,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
