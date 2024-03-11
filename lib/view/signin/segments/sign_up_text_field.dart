part of '../sign_up_screen.dart';

Widget signUpTextField({
  required TextEditingController controller,
  required String title,
  required IconData icon,
  bool? isNumber,
}) {
  return TextFormField(
    style: GoogleFonts.roboto(
      fontSize: screenSize.width * .035,
    ),
    controller: controller,
    keyboardType: isNumber == true ? TextInputType.number : null,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 16,
      ),
      prefixIcon: Icon(icon),
      labelText: title,
      labelStyle: GoogleFonts.poppins(
        fontSize: screenSize.width * .035,
        color: Colors.black.withOpacity(.7),
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
        return 'TextFields cannot be blank';
      } else if (isNumber == true) {
        if (value.length != 10) {
          return 'Mobile number should be 10 digits';
        } else if (int.tryParse(value) == null) {
          return 'Enter a valid phone number';
        } else {
          return null;
        }
      } else if (value.length < 2) {
        return 'Field should be filled correctly';
      } else {
        return null;
      }
    },
  );
}
