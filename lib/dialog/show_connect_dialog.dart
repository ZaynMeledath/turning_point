import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/connect/connect_bloc.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:url_launcher/url_launcher.dart';

Future<Object?> showConnectDialog(
    {required BuildContext context, required bool isDark}) async {
  // return showModalBottomSheet(

  //     context: context,
  //     builder: (context) {
  //       return dialog(context);
  //     });

  return showGeneralDialog(
    context: context,
    barrierColor: Colors.transparent,
    pageBuilder: (context, a1, a2) {
      return Container();
    },
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (context, a1, a2, child) {
      final curve = Curves.easeInOut.transform(a1.value);
      return Transform.scale(
        alignment: Alignment.bottomRight,
        scale: curve,
        child: dialog(
          context: context,
          isDark: isDark,
        ),
      );
    },
  );
}

Widget dialog({
  required BuildContext context,
  required bool isDark,
}) {
  return Stack(
    children: [
      GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          color: Colors.transparent,
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: screenSize.width * .051,
              right: screenSize.width * .051,
              bottom: screenSize.height * .075,
            ),
            padding: EdgeInsets.only(
              top: screenSize.height * .02,
              bottom: screenSize.height * .015,
            ),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xff0c1313) : Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(1, 0),
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 4,
                  blurStyle: BlurStyle.solid,
                ),
                BoxShadow(
                  offset: const Offset(-1, -1),
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 4,
                  blurStyle: BlurStyle.solid,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  //====================Turning Point Logo and Name====================//
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/turning_point_logo_icon.png',
                        width: screenSize.width * .07,
                      ),
                      SizedBox(width: screenSize.width * .02),
                      DefaultTextStyle(
                        style: GoogleFonts.poppins(
                          fontSize: screenSize.width * .041,
                          color: isDark ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                        child: const Text('Turning Point'),
                      )
                    ],
                  ),
                  SizedBox(height: screenSize.height * .02),
                  Container(
                    width: double.maxFinite,
                    height: 1,
                    color: isDark
                        ? Colors.white.withOpacity(.2)
                        : Colors.black.withOpacity(.1),
                  ),
                  SizedBox(height: screenSize.height * .024),

                  //====================Phone and WhatsApp Row====================//
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        highlightColor: Colors.blue[100],
                        splashColor: Colors.blue[50]!.withOpacity(.3),
                        borderRadius: BorderRadius.circular(6),
                        onTap: () => connectBloc.add(PhoneConnectEvent()),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/icons/phone_icon.png',
                              width: screenSize.width * .1,
                            ),
                            SizedBox(height: screenSize.height * .01),
                            DefaultTextStyle(
                              style: GoogleFonts.inter(
                                fontSize: screenSize.width * .031,
                                color: isDark ? Colors.white : Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                              child: const Text('Phone'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: screenSize.width * .15),
                      InkWell(
                        highlightColor: Colors.green[300],
                        splashColor: Colors.green[50]!.withOpacity(.3),
                        borderRadius: BorderRadius.circular(6),
                        onTap: () => connectBloc.add(WhatsAppConnectEvent()),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/icons/whatsapp_icon.png',
                              width: screenSize.width * .1,
                            ),
                            SizedBox(height: screenSize.height * .01),
                            DefaultTextStyle(
                              style: GoogleFonts.inter(
                                fontSize: screenSize.width * .031,
                                color: isDark ? Colors.white : Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                              child: const Text('WhatsApp'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.height * .022),
                  Container(
                    width: double.maxFinite,
                    height: 1,
                    color: isDark
                        ? Colors.white.withOpacity(.2)
                        : Colors.black.withOpacity(.1),
                  ),
                  SizedBox(height: screenSize.height * .015),

                  //====================Follow Us Row====================//
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * .04),
                    child: InkWell(
                      highlightColor: Colors.pink[100],
                      splashColor: Colors.pink[50]!.withOpacity(.3),
                      borderRadius: BorderRadius.circular(6),
                      onTap: () => launchUrl(
                        Uri.parse(
                            'https://www.instagram.com/turningpointvapi?igsh=Y2M5aWJ5ZTNiMTBv'),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DefaultTextStyle(
                            style: GoogleFonts.inter(
                              fontSize: screenSize.width * .031,
                              color: isDark ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                            child: const Text('Follow Us On'),
                          ),
                          SizedBox(width: screenSize.width * .01),
                          Image.asset(
                            'assets/icons/instagram_icon.png',
                            width: screenSize.width * .04,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
