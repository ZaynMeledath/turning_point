import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';

Widget dropDownContainer() {
  final contractorList = ['JOHN', 'JACOB', 'SEAN', 'ADHIL'];
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: const Color.fromRGBO(16, 16, 16, .5),
      ),
    ),
    child: DropdownButtonFormField(
      borderRadius: BorderRadius.circular(12),
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * .041),
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      items: [
        for (int i = 0; i < contractorList.length; i++)
          DropdownMenuItem(
            value: contractorList[i],
            child: Text(
              contractorList[i],
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .034,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
      ],
      onChanged: (value) {},
    ),
  );
}
