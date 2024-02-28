import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';

Widget kycTextFieldSegment({
  required TextEditingController controller,
  required String title,
  bool? isNum,
  bool? isEmail,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .041),
    child: Center(
      child: SizedBox(
        height: screenSize.height * .058,
        child: TextFormField(
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .035,
          ),
          controller: controller,
          keyboardType: isNum == true ? TextInputType.number : null,
          decoration: InputDecoration(
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
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
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
    ),
  );
}
