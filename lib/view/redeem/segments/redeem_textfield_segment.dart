import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget redeemTextFieldSegment({
  required Size screenSize,
  required TextEditingController controller,
}) {
  return Container(
    width: double.infinity,
    height: screenSize.width * .12,
    margin: EdgeInsets.symmetric(horizontal: screenSize.width * .05),
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .03),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: const Color.fromRGBO(142, 142, 142, 1),
      ),
    ),
    child: Row(
      children: [
        Flexible(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            style: GoogleFonts.inter(
              fontSize: screenSize.width * .033,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: 'Enter the points you want to redeem',
              hintStyle: GoogleFonts.inter(
                fontSize: screenSize.width * .033,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        const Icon(Icons.currency_rupee)
      ],
    ),
  );
}
