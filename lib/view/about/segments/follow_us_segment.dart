part of 'package:turning_point/view/about/about_us_screen.dart';

Widget followUsSegment() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .051),
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        //Navigator goes here
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.share,
                size: screenSize.width * .051,
                color: const Color.fromRGBO(105, 105, 105, 1),
              ),
              SizedBox(width: screenSize.width * .036),
              Text(
                'Follow Us',
                style: GoogleFonts.roboto(
                  fontSize: screenSize.width * .041,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: screenSize.width * .03,
            color: const Color.fromRGBO(105, 105, 105, 1),
          ),
        ],
      ),
    ),
  );
}
