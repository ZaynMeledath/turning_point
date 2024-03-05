import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';

Widget kycTextFieldSegment({
  required TextEditingController controller,
  required String title,
  TextEditingController? accNumController,
  bool? isNum,
  bool? isEmail,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .041),
    child: Center(
      child: TextFormField(
        style: GoogleFonts.poppins(
          fontSize: screenSize.width * .035,
        ),
        controller: controller,
        keyboardType: isNum == true ? TextInputType.number : null,
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
          labelStyle: GoogleFonts.poppins(
            fontSize: screenSize.width * .035,
          ),
          floatingLabelStyle: GoogleFonts.poppins(
            fontSize: screenSize.width * .035,
            // color: const Color.fromRGBO(52, 110, 241, 1),
            color: Colors.black.withOpacity(.7),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.black.withOpacity(.3),
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
            return '$title field cannot be blank';
          } else if (isEmail == true) {
            const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
            final regEx = RegExp(pattern);

            return !regEx.hasMatch(value)
                ? 'Enter a valid email address'
                : null;
          } else if (isNum == true) {
            final regEx = RegExp(r'[0-9]');
            if (title == 'Confirm Account Number') {
              log('${accNumController!.text} : $value');
              return value != accNumController.text
                  ? 'Account numbers should match'
                  : null;
            }
            return !regEx.hasMatch(value) ? 'Enter a valid value' : null;
          } else if (isNum == false) {
            final regEx = RegExp(r'[A-Z][a-z]');
            return !regEx.hasMatch(value) ? 'Enter a valid name' : null;
          } else {
            return null;
          }
        },
      ),
    ),
  );
}
