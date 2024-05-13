import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/utilities/screen_size.dart';

Widget kycIdCaptureContainer({
  required String title,
  required bool isActive,
  bool? isSelfie,
}) {
  return Container(
    width: screenSize.width * .28,
    height: screenSize.width * .09,
    decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [
        Color.fromRGBO(184, 184, 184, .2),
        Color.fromRGBO(239, 239, 239, .3),
        Color.fromRGBO(184, 184, 184, .2),
      ]),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Icon(
        //   isSelfie == true ? Icons.camera_front_rounded : Icons.document_scanner,
        //   color: isActive
        //       ? Colors.black87
        //       : const Color.fromRGBO(215, 215, 215, 1),
        //   size: screenSize.width * .05,
        // ),
        isSelfie == true
            ? Image.asset(
                'assets/icons/kyc_selfie_icon.png',
                width: screenSize.width * .055,
                color: isActive ? null : const Color.fromRGBO(215, 215, 215, 1),
              )
            : isActive
                ? Image.asset(
                    'assets/icons/kyc_id_icon.png',
                    width: screenSize.width * .055,
                  )
                : Image.asset(
                    'assets/icons/kyc_id_disabled_icon.png',
                    width: screenSize.width * .055,
                    color: const Color.fromRGBO(215, 215, 215, 1),
                  ),
        SizedBox(width: screenSize.width * .012),
        Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .036,
            fontWeight: FontWeight.w400,
            color: isActive
                ? Colors.black
                : const Color.fromRGBO(215, 215, 215, 1),
          ),
        ),
      ],
    ),
  );
}
