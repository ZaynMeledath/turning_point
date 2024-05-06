import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point/helper/screen_size.dart';

typedef ButtonFuction = void Function();

Future<Object?> showAnimatedGenericDialog({
  required BuildContext context,
  required String iconPath,
  required String title,
  required String content,
  required Map<String, ButtonFuction?> buttons,
  double? iconWidth,
  // Size? containerSize,
}) async {
  return showGeneralDialog(
    context: context,
    pageBuilder: (context, a1, a2) {
      return Container();
    },
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (context, a1, a2, child) {
      final curve = Curves.easeInOut.transform(a1.value);
      return Transform.scale(
        scale: curve,
        child: dialog(
          context: context,
          iconPath: iconPath,
          title: title,
          content: content,
          iconWidth: iconWidth,
          buttons: buttons,
        ),
      );
    },
  );
}

Widget dialog({
  required BuildContext context,
  required String iconPath,
  required String title,
  required String content,
  required Map<String, ButtonFuction?> buttons,
  double? iconWidth,
}) {
  final isLottie = iconPath.split('.').last == 'json';
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: screenSize.width * .62,
        padding: EdgeInsets.symmetric(
          horizontal: realScreenSize.width * .05,
          vertical: screenSize.width * .05,
        ),
        margin: EdgeInsets.symmetric(horizontal: screenSize.width * .14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            // SizedBox(
            //   height:
            //       isLottie ? screenSize.height * .11 : screenSize.height * .02,
            // ),
            isLottie
                ? Lottie.asset(
                    iconPath,
                    width: iconWidth ?? screenSize.width * .15,
                  )
                : Image.asset(
                    iconPath,
                    width: iconWidth ?? screenSize.width * .15,
                  ),
            SizedBox(
              height: isLottie
                  ? screenSize.height * .005
                  : screenSize.height * .014,
            ),
            DefaultTextStyle(
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .046,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: screenSize.height * .012),
            DefaultTextStyle(
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .035,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                height: 1.4,
              ),
              child: Text(
                content,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: screenSize.height * .028),
            buttons.length > 1
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < buttons.length; i++)
                        GestureDetector(
                          onTap: buttons.values.elementAt(i) ??
                              () => Navigator.pop(context),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * .04,
                              vertical: screenSize.width * .016,
                            ),
                            margin:
                                EdgeInsets.only(left: screenSize.width * .03),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: i == 0
                                  ? Colors.white
                                  : const Color.fromRGBO(0, 99, 255, 1),
                              border: Border.all(
                                color: i == 0
                                    ? const Color.fromRGBO(0, 99, 255, 1)
                                    : Colors.transparent,
                              ),
                            ),
                            child: DefaultTextStyle(
                              style: GoogleFonts.roboto(
                                fontSize: screenSize.width * .031,
                                fontWeight: FontWeight.w500,
                                color: i == 0
                                    ? const Color.fromRGBO(0, 99, 255, 1)
                                    : Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  buttons.keys.elementAt(i),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                : GestureDetector(
                    onTap: buttons.values.first ?? () => Navigator.pop(context),
                    child: Container(
                      width: screenSize.width * .25,
                      height: screenSize.width * .085,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromRGBO(0, 99, 255, 1),
                      ),
                      child: DefaultTextStyle(
                        style: GoogleFonts.roboto(
                          fontSize: screenSize.width * .031,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            buttons.keys.first,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    ],
  );
}
