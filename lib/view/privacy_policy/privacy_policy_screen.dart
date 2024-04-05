import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/widget/my_app_bar.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/title_content_text.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  final bool isAccepted;
  const PrivacyPolicyScreen({
    required this.isAccepted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const text =
        "The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.";
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
//====================AppBar====================//
            myAppBar(
              context: context,
              title: 'Privacy & Policy',
            ),
            SizedBox(height: screenSize.height * .01),

//====================Illustration====================//
            Image.asset(
              'assets/images/privacy_policy_image.png',
              width: screenSize.width * .64,
            ),
            SizedBox(height: screenSize.height * .02),

//====================Title (Privacy & Policy)====================//
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

//====================Privacy and Policy====================//
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * .051),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    titleContentText(isTitle: true, text: text),
                    titleContentText(isTitle: false, text: text),
                    titleContentText(isTitle: false, text: text),
                    titleContentText(isTitle: false, text: text),
                    titleContentText(isTitle: false, text: text),
                    titleContentText(isTitle: true, text: text),
                    titleContentText(isTitle: false, text: text),
                    titleContentText(isTitle: true, text: text),
                    titleContentText(isTitle: false, text: text),
                    titleContentText(isTitle: false, text: text),
                  ],
                ),
              ),
            ),

//====================Accept Button====================//
            Visibility(
              visible: !isAccepted,
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
