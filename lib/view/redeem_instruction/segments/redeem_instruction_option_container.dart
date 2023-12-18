import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget redeemInstructionOptionContainer({
  required Size screenSize,
  required String title,
  required Color containerColor,
  required String iconPath,
}) {
  return Container(
    width: double.infinity,
    height: screenSize.width * .181,
    margin: EdgeInsets.symmetric(horizontal: screenSize.width * .041),
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .06),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: const Color.fromRGBO(247, 247, 247, 1),
    ),
    child: Row(
      children: [
        Container(
          width: screenSize.width * .13,
          height: screenSize.width * .13,
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 1),
                blurRadius: 1.25,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
        ),
        SizedBox(width: screenSize.width * .041),
        Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .031,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Color.fromRGBO(142, 142, 142, 1),
            ),
          ),
        )
      ],
    ),
  );
}
