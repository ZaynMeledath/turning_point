part of '../redeem_screen.dart';

Widget redeemUpiTextField(TextEditingController upiController) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: const [
        BoxShadow(
          offset: Offset(-1.5, 1.5),
          blurRadius: 1,
          color: Color.fromRGBO(0, 0, 0, .25),
        ),
        BoxShadow(
          offset: Offset(1.5, -.5),
          blurRadius: 1,
          color: Color.fromRGBO(0, 0, 0, .25),
        ),
      ],
    ),
    child: Center(
      child: TextFormField(
        controller: upiController,
        style: GoogleFonts.inter(
          fontSize: screenSize.width * .031,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
          hintText: 'UPI ID',
          hintStyle: GoogleFonts.inter(
            fontSize: screenSize.width * .031,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    ),
  );
}
