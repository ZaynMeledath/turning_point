import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/my_app_bar.dart';
import 'package:turning_point/helper/widget/title_content_text.dart';
import 'package:turning_point/view/boarding/boarding_screen.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  final bool isAccepted;
  const TermsAndConditionsScreen({
    required this.isAccepted,
    super.key,
  });

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  final titleText =
      "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.";
  final contentText =
      "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).";

  bool isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
//====================AppBar====================//
              widget.isAccepted
                  ? myAppBar(
                      context: context,
                      title: 'Terms and Conditions',
                      backgroundColor: Colors.white,
                    )
                  : Column(
                      children: [
                        SizedBox(height: screenSize.height * .011),
                        Text(
                          'Terms and Conditions',
                          style: GoogleFonts.roboto(
                            fontSize: screenSize.width * .041,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
              SizedBox(height: screenSize.height * .007),

//====================Terms and Conditions====================//
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * .05),
                  child: ListView(
                    children: [
                      titleContentText(isTitle: true, text: titleText),
                      titleContentText(isTitle: false, text: contentText),
                      titleContentText(isTitle: true, text: titleText),
                      titleContentText(isTitle: false, text: contentText),
                      titleContentText(isTitle: true, text: titleText),
                      titleContentText(isTitle: false, text: contentText),
                      titleContentText(isTitle: true, text: titleText),
                      titleContentText(isTitle: false, text: contentText),
                    ],
                  ),
                ),
              ),

//====================Agree Terms Section====================//
              !widget.isAccepted
                  ? Column(
                      children: [
                        SizedBox(height: screenSize.height * .021),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isAgreed = !isAgreed;
                                });
                              },
                              child: Container(
                                width: screenSize.width * .041,
                                height: screenSize.width * .041,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(
                                    width: 2,
                                    color: const Color.fromRGBO(0, 99, 255, 1),
                                  ),
                                ),
                                child: Visibility(
                                  visible: isAgreed,
                                  child: Center(
                                    child: Container(
                                      width: screenSize.width * .021,
                                      height: screenSize.width * .021,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color:
                                            const Color.fromRGBO(0, 99, 255, 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: screenSize.width * .031),
                            Text(
                              'I agree with the Terms and Conditions',
                              style: GoogleFonts.roboto(
                                fontSize: screenSize.width * .03,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize.height * .024),

//====================Continue Button====================//
                        GestureDetector(
                          onTap: () {
                            if (!isAgreed) {
                              return;
                            }
                            Navigator.of(context).pushAndRemoveUntil(
                              PageTransition(
                                child: const BoardingScreen(),
                                type: PageTransitionType.scale,
                                alignment: Alignment.center,
                                duration: const Duration(milliseconds: 400),
                              ),
                              (route) => false,
                            );
                          },
                          child: Container(
                            width: screenSize.width * .37,
                            height: screenSize.width * .1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: isAgreed
                                  ? const Color.fromRGBO(0, 99, 255, 1)
                                  : Colors.grey,
                            ),
                            child: Center(
                              child: Text(
                                'Continue',
                                style: GoogleFonts.roboto(
                                  fontSize: screenSize.width * .031,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenSize.height * .035),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
