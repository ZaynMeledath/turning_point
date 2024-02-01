import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget kycTextFieldSegment({
  required Size screenSize,
  required TextEditingController controller,
  required String title,
  bool? isNum,
  bool? isEmail,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .041),
    child: Center(
      child: SizedBox(
        height: screenSize.height * .056 + (screenSize.height * .019) / 2,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
//====================TextField Container====================//
            Container(
              width: double.infinity,
              height: screenSize.height * .056,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 1,
                  color: const Color.fromRGBO(142, 142, 142, 1),
                ),
              ),
//====================TextField and Pencil Icon====================//
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: controller,
                      keyboardType: isNum == true
                          ? TextInputType.number
                          : isEmail == true
                              ? TextInputType.emailAddress
                              : TextInputType.text,
                      style: GoogleFonts.inter(
                        fontSize: screenSize.height * .017,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        hintText: title,
                        hintStyle: GoogleFonts.inter(
                          fontSize: screenSize.height * .017,
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/icons/pencil_icon.png',
                    width: screenSize.width * .051,
                    height: screenSize.width * .051,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
