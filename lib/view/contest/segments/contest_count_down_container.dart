part of '../contest_screen.dart';

Widget contestCountDownContainer({
  required String time,
  required String title,
}) {
  return Container(
    width: screenSize.width * .095,
    height: screenSize.width * .11,
    decoration: BoxDecoration(
        color: const Color.fromRGBO(236, 236, 236, 1),
        borderRadius: BorderRadius.circular(3),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 3,
            color: Color.fromRGBO(121, 121, 121, 0.25),
            blurStyle: BlurStyle.inner,
          ),
        ]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(),
            child: Center(
              child: Text(
                time,
                style: GoogleFonts.roboto(
                  fontSize: screenSize.width * .05,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: screenSize.width * .03,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(3),
            ),
            color: Colors.black,
          ),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .016,
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
