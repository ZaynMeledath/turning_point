import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textFieldSegment({
  required Size screenSize,
  required TextEditingController controller,
  required String title,
  bool? isNumber,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .041),
    child: Center(
      child: TextFormField(
        style: GoogleFonts.inter(
          fontSize: screenSize.width * .035,
        ),
        controller: controller,
        keyboardType: isNumber == true ? TextInputType.number : null,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15,
          ),
          suffixIcon: Icon(
            CupertinoIcons.pencil,
            size: screenSize.width * .05,
          ),
          labelText: title,
          labelStyle: GoogleFonts.inter(
            fontSize: screenSize.width * .035,
          ),
          floatingLabelStyle: GoogleFonts.inter(
            fontSize: screenSize.width * .035,
            // color: const Color.fromRGBO(52, 110, 241, 1),
            color: Colors.black.withOpacity(.7),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.black.withOpacity(.4),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              // color: Color.fromRGBO(52, 110, 241, 1),
              color: Colors.black.withOpacity(.7),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'TextFields cannot be blank';
          } else {
            return null;
          }
        },
      ),
    ),
  );
}
