import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/my_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

part 'segments/about_company_container.dart';
part 'segments/follow_us_segment.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  String version = '';
  @override
  void initState() {
    getVersion();
    super.initState();
  }

  void getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            myAppBar(context: context, title: 'About Us'),
            SizedBox(height: screenSize.height * .03),
//====================About App Segment====================//
            Image.asset(
              'assets/icons/turning_point_logo_icon.png',
              width: screenSize.width * .2,
            ),
            SizedBox(height: screenSize.height * .012),
            Text(
              'TURNING POINT',
              style: GoogleFonts.poppins(
                letterSpacing: 4,
                color: const Color.fromRGBO(239, 64, 68, 1),
                fontSize: screenSize.width * .05,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'v$version',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .041,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenSize.height * .045),
//====================About Company Segment====================//
            aboutCompanyContainer(
              title: 'Turning Point',
              content:
                  'At Turningpoint, we believe in turning living spaces into sanctuaries. Established with a passion for craftsmanship and an unwavering commitment to quality, we curate furniture that resonates with both elegance and functionality.',
              imagePath: 'assets/icons/turning_point_logo_icon.png',
            ),
            SizedBox(height: screenSize.height * .04),

            aboutCompanyContainer(
              title: 'Furnipart',
              content:
                  'At Furnipart, we believe in turning living spaces into sanctuaries. Established with a passion for craftsmanship and an unwavering commitment to quality, we curate furniture that resonates with both elegance and functionality.',
              imagePath: 'assets/images/furnipart_logo.png',
            ),
            SizedBox(height: screenSize.height * .04),

            aboutCompanyContainer(
              title: 'Claart',
              content:
                  'At Claart, we believe in turning living spaces into sanctuaries. Established with a passion for craftsmanship and an unwavering commitment to quality, we curate furniture that resonates with both elegance and functionality.',
              imagePath: 'assets/images/claart_logo_with_bg.png',
            ),
            SizedBox(height: screenSize.height * .06),
            followUsSegment(),
          ],
        ),
      ),
    );
  }
}
