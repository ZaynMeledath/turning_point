part of 'package:turning_point/view/about/about_us_screen.dart';

Widget aboutCompanyContainer({
  required String title,
  required String content,
  required String imagePath,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .041),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              width: screenSize.width * .21,
            ),
            SizedBox(height: screenSize.height * .005),
            Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .034,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(width: screenSize.width * .03),
        Expanded(
          child: Text(
            content,
            softWrap: true,
            style: GoogleFonts.roboto(
              fontSize: screenSize.width * .03,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    ),
  );
}
