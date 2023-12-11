import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textFieldSegment({
  required Size screenSize,
  required TextEditingController controller,
  required String title,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .041),
    child: Center(
      child: SizedBox(
        height: screenSize.height * .056 + (screenSize.height * .019) / 2,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
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
              child: Center(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: screenSize.width * .05,
              child: Container(
                height: screenSize.height * .019,
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * .028),
                color: Colors.white,
                child: Center(
                  child: Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: screenSize.width * .031,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
