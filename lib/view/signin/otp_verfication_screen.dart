import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:turning_point/bloc/auth/auth_bloc.dart';
import 'package:turning_point/dialog/show_custom_loading_dialog.dart';
import 'package:turning_point/dialog/show_generic_dialog.dart';
import 'package:turning_point/helper/custom_navigator.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/terms_and_conditions/terms_and_conditions_screen.dart';
// part 'package:turning_point/view/login/segments/otp_container.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String otp = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          showCustomLoadingDialog(context);
        } else if (state is OtpVerifiedState) {
          Navigator.pop(context);
          CustomNavigator.pushAndRemove(
            context: context,
            child: const TermsAndConditionsScreen(isAccepted: false),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              //====================Background Decoration Circles====================//
              Positioned(
                top: -screenSize.width * .22,
                left: -screenSize.width * .15,
                child: Container(
                  width: screenSize.width * .74,
                  height: screenSize.width * .74,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(247, 247, 247, 1),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(177, 177, 177, 0.04),
                        offset: Offset(41, 4),
                        blurRadius: 4,
                        blurStyle: BlurStyle.outer,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: screenSize.height * .4,
                right: -screenSize.width * .1,
                child: Container(
                  width: screenSize.width * .48,
                  height: screenSize.width * .48,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(247, 247, 247, 1),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(177, 177, 177, 0.04),
                        offset: Offset(41, 4),
                        blurRadius: 4,
                        blurStyle: BlurStyle.outer,
                      ),
                    ],
                  ),
                ),
              ),

              //====================Illustration====================//
              Positioned(
                top: screenSize.height * .16,
                child: Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/otp_screen_image.png',
                        width: screenSize.width * .6,
                      ),
                      SizedBox(height: screenSize.height * .03),

                      //====================Body Texts Segment====================//
                      Text(
                        'VERIFICATION CODE',
                        style: GoogleFonts.roboto(
                          fontSize: screenSize.width * .051,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(29, 29, 29, 1),
                        ),
                      ),
                      SizedBox(height: screenSize.height * .011),
                      Text(
                        'Please enter the verification code sent to',
                        style: GoogleFonts.roboto(
                          fontSize: screenSize.width * .036,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(29, 29, 29, 1),
                        ),
                      ),
                      SizedBox(height: screenSize.height * .01),
                      Text(
                        '+91 ${state.phone}',
                        style: GoogleFonts.roboto(
                          fontSize: screenSize.width * .038,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                      SizedBox(height: screenSize.height * .025),

                      //====================OTP Containers====================//
                      OTPTextField(
                        fieldStyle: FieldStyle.box,
                        length: 6,
                        outlineBorderRadius: 8,
                        fieldWidth: screenSize.width * .09,
                        otpFieldStyle: OtpFieldStyle(
                          borderColor: const Color.fromRGBO(155, 155, 155, 1),
                        ),
                        width: screenSize.width * .7,
                        onChanged: (value) {},
                        onCompleted: (value) {
                          otp = value;
                        },
                      ),

                      SizedBox(height: screenSize.height * .01),

                      //====================Resend OTP====================//
                      Row(
                        children: [
                          Text(
                            "Didn't Receive the OTP? ",
                            style: GoogleFonts.roboto(
                              fontSize: screenSize.width * .031,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Resend',
                            style: GoogleFonts.roboto(
                              fontSize: screenSize.width * .035,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(0, 99, 255, 1),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * .21),

                      //====================Verify Button====================//
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () {
                              if (otp.length == 6) {
                                authBloc.add(VerifyOtpEvent(otp));
                              } else {
                                showGenericDialog(
                                  context: context,
                                  title: 'OTP Incorrect',
                                  content: 'Please enter all the 6 digits',
                                  options: {'OK': null},
                                );
                              }
                            },
                            child: Container(
                              width: screenSize.width * .37,
                              height: screenSize.width * .11,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: const Color.fromRGBO(0, 99, 255, 1),
                              ),
                              child: Center(
                                child: Text(
                                  'Verify',
                                  style: GoogleFonts.roboto(
                                    fontSize: screenSize.width * .031,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

//   Widget otpContainer({
//     required TextEditingController controller,
//     required FocusNode focusNode,
//   }) {
//     return Container(
//       width: screenSize.width * .09,
//       height: screenSize.width * .09,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(4),
//         border: Border.all(
//           color: focusNode.hasFocus
//               ? Colors.blue
//               : const Color.fromRGBO(155, 155, 155, 1),
//         ),
//       ),
//       child: TextField(
//         cursorColor: const Color.fromRGBO(0, 99, 255, 1),
//         controller: controller,
//         focusNode: focusNode,
//         textAlignVertical: TextAlignVertical.center,
//         // autofocus: true,
//         // showCursor: false,
//         keyboardType: TextInputType.number,
//         inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//         maxLength: 1,
//         textAlign: TextAlign.center,
//         decoration: const InputDecoration(
//           border: InputBorder.none,
//           counterText: '',
//         ),
//         onChanged: (value) {
//           if (value.isEmpty) {
//             if (controller == _textController1) {
//               return;
//             }
//             focusNode.previousFocus();
//           }

//           if (value.isNotEmpty) {
//             focusNode.nextFocus();
//             if (controller == _textController6) {
//               focusNode.unfocus();
//             }
//           }

//           setState(() {});
//         },
//         onTap: () {
//           setState(() {});
//         },
//       ),
//     );
//   }
}
