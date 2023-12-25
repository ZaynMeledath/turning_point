import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/widget/custom_app_bar.dart';
import 'package:turning_point/helper/screen_size.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  final bool shouldAccept;
  const PrivacyPolicyScreen({
    required this.shouldAccept,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            customAppBar(
              context: context,
              title: 'Privacy & Policy',
            ),
            Image.asset(
              'assets/images/privacy_policy_image.png',
              width: screenSize.width * .64,
            ),
            SizedBox(height: screenSize.height * .02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/key_lock_icon.png',
                  width: screenSize.width * .052,
                ),
                SizedBox(width: screenSize.width * .006),
                Column(
                  children: [
                    SizedBox(height: screenSize.width * .012),
                    Text(
                      'PRIVACY & POLICY',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .051,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenSize.height * .01),
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * .051),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Text(
                      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .03,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: screenSize.height * .01),
                    Text(
                      "The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .028,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: screenSize.height * .018),
                    Text(
                      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .03,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: screenSize.height * .01),
                    Text(
                      "The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .028,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: screenSize.height * .01),
                    Text(
                      "The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .028,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                    Text(
                      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .03,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: screenSize.height * .01),
                    Text(
                      "The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .028,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: screenSize.height * .018),
                    Text(
                      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .03,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: screenSize.height * .01),
                    Text(
                      "The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .028,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: screenSize.height * .01),
                    Text(
                      "The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .028,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: shouldAccept,
              child: Container(
                width: screenSize.width * .37,
                height: screenSize.width * .11,
                margin: EdgeInsets.only(
                  bottom: screenSize.height * .025,
                  top: screenSize.height * .008,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color.fromRGBO(0, 99, 255, 1),
                ),
                child: Center(
                  child: Text(
                    'Accept',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: screenSize.width * .034,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
