import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_app_bar.dart';

part 'segments/about_company_container.dart';
part 'segments/follow_us_segment.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            customAppBar(context: context, title: 'About Us'),
            SizedBox(height: screenSize.height * .02),
            Image.asset(
              'assets/images/splash_logo.png',
              width: screenSize.width * .2,
            ),
            Text(
              'FURNIPART',
              style: GoogleFonts.poppins(
                letterSpacing: 4,
                color: const Color.fromRGBO(239, 64, 68, 1),
                fontSize: screenSize.width * .05,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'v1.0.0',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .041,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: screenSize.height * .045),
            aboutCompanyContainer(
              title: 'Furnipart',
              content:
                  'At Furnipart, we believe in turning living spaces into sanctuaries. Established with a passion for craftsmanship and an unwavering commitment to quality, we curate furniture that resonates with both elegance and functionality.',
              imagePath: 'assets/images/company_image_demo1.png',
            ),
            SizedBox(height: screenSize.height * .035),
            aboutCompanyContainer(
              title: 'Turning Point',
              content:
                  'At Turningpoint, we believe in turning living spaces into sanctuaries. Established with a passion for craftsmanship and an unwavering commitment to quality, we curate furniture that resonates with both elegance and functionality.',
              imagePath: 'assets/images/company_image_demo2.png',
            ),
            SizedBox(height: screenSize.height * .035),
            aboutCompanyContainer(
              title: 'Claart',
              content:
                  'At Clart, we believe in turning living spaces into sanctuaries. Established with a passion for craftsmanship and an unwavering commitment to quality, we curate furniture that resonates with both elegance and functionality.',
              imagePath: 'assets/images/company_image_demo3.png',
            ),
            SizedBox(height: screenSize.height * .045),
            followUsSegment(),
          ],
        ),
      ),
    );
  }
}
