part of 'package:turning_point/view/about/about_us_screen.dart';

Widget aboutCompanyContainer({
  required String title,
  required String content,
  required String imagePath,
  double? imageWidth,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .031),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          // color: Colors.amber,
          width: screenSize.width * .23,
          height: screenSize.height * .1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  imagePath,
                  width: screenSize.width * .2,
                  height: screenSize.height * .06,
                ),
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
