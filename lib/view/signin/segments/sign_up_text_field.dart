part of '../sign_up_screen.dart';

Widget signUpTextField({
  required TextEditingController controller,
  required String title,
  required IconData icon,
  bool? isNumber,
}) {
  return SizedBox(
    height: screenSize.height * .06,
    child: TextFormField(
      style: GoogleFonts.roboto(
        fontSize: screenSize.width * .035,
      ),
      controller: controller,
      keyboardType: isNumber == true ? TextInputType.number : null,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
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
  );
}
