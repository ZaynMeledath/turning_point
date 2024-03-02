import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/helper/screen_size.dart';

Future<Object?> showAnimatedOtpDialog({
  required BuildContext context,
  required String phone,
  required TextEditingController otpController,
}) async {
  return showGeneralDialog(
    context: context,
    pageBuilder: (context, a1, a2) {
      return Container();
    },
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (context, a1, a2, child) {
      final curve = Curves.easeInOut.transform(a1.value);
      return Transform.scale(
        scale: curve,
        child: dialog(
          context: context,
          phone: phone,
          otpController: otpController,
        ),
      );
    },
  );
}

Widget dialog({
  required BuildContext context,
  required String phone,
  required TextEditingController otpController,
}) {
  String otp = '';
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: screenSize.width * .1,
      vertical: screenSize.height * .34,
    ),
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .03),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      children: [
        SizedBox(height: screenSize.height * .025),
        Image.asset(
          'assets/images/otp_screen_image.png',
          width: screenSize.width * .15,
        ),
        SizedBox(height: screenSize.height * .018),
        DefaultTextStyle(
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .051,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          child: const Text(
            'Enter the OTP',
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: screenSize.height * .015),
        Material(
          child: Pinput(
            controller: otpController,
            length: 6,
            defaultPinTheme: PinTheme(
              width: screenSize.width * .1,
              height: screenSize.width * .1,
              textStyle: GoogleFonts.roboto(
                fontSize: screenSize.width * .05,
                color: const Color.fromRGBO(30, 60, 87, 1),
                fontWeight: FontWeight.w600,
              ),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(234, 239, 243, 1),
                borderRadius: BorderRadius.circular(8),
                //   border: Border.all(
                //     color: const Color.fromRGBO(234, 239, 243, 1),
                //   ),
              ),
            ),
            androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
            onChanged: (value) {},
            onCompleted: (value) {
              otp = value;
            },
          ),
        ),
        SizedBox(height: screenSize.height * .04),
        GestureDetector(
          onTap: () {
            profileBloc.add(
              ProfileVerifyOtpEvent(
                phone: phone,
                otp: otp,
              ),
            );
            Navigator.pop(context);
          },
          child: Container(
            width: screenSize.width * .25,
            height: screenSize.width * .085,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromRGBO(0, 99, 255, 1),
            ),
            child: DefaultTextStyle(
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .041,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              child: const Center(
                child: Text(
                  'Verify',
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}


// Widget dialog({
//   required BuildContext context,
// }) {
//   String otp = '';
  
// }
