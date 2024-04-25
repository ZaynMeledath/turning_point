part of 'package:turning_point/view/about/about_us_screen.dart';

Widget followUsSegment() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .051),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              'Follow Us On ',
              style: GoogleFonts.inter(
                fontSize: screenSize.width * .035,
                fontWeight: FontWeight.w500,
              ),
            ),
            Image.asset(
              'assets/icons/instagram_icon.png',
              width: screenSize.width * .04,
            ),
            // SizedBox(width: screenSize.width * .05),
          ],
        ),
        SizedBox(height: screenSize.height * .015),
        Row(
          children: [
            GestureDetector(
              onTap: () => launchUrl(
                Uri.parse(
                    'https://www.instagram.com/turningpointvapi?igsh=Y2M5aWJ5ZTNiMTBv'),
              ),
              child: Image.asset(
                'assets/icons/turning_point_logo_icon.png',
                width: screenSize.width * .08,
              ),
            ),
            SizedBox(width: screenSize.width * .05),
            GestureDetector(
              onTap: () => launchUrl(
                Uri.parse(
                    'https://www.instagram.com/claartindia?igsh=MWNjbDkxc2VxOWU0Yw=='),
              ),
              child: Image.asset(
                'assets/images/claart_logo_with_bg.png',
                width: screenSize.width * .12,
              ),
            ),
            SizedBox(width: screenSize.width * .05),
            GestureDetector(
              onTap: () => launchUrl(
                Uri.parse(
                    'https://www.instagram.com/furnipart_vapi?igsh=MTduM29ud24zenVzNg=='),
              ),
              child: Image.asset(
                'assets/images/furnipart_logo.png',
                width: screenSize.width * .12,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
