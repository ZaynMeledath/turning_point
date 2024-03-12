import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';

Future<Object?> showLoadingDialog({
  required BuildContext context,
  String? loadingText,
}) async {
  final dialog = Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SpinKitSpinningLines(color: Colors.white),
        if (loadingText != null)
          Text(
            loadingText,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: screenSize.width * .035,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
      ],
    ),
  );

  return showDialog(
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(.2),
    context: context,
    builder: (context) => dialog,
  );
}
