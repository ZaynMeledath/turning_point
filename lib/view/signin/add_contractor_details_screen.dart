import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/auth/auth_bloc.dart';
import 'package:turning_point/dialog/show_custom_loading_dialog.dart';
import 'package:turning_point/utils/custom_navigator.dart';
import 'package:turning_point/utils/screen_size.dart';
import 'package:turning_point/model/contractor_model.dart';
import 'package:turning_point/view/signin/otp_verification_screen.dart';
import 'package:turning_point/view/signin/sign_up_screen.dart';

class AddContractorDetailsScreen extends StatefulWidget {
  final String phone;
  final TextEditingController otpController;
  final String refCode;
  final Position? location;
  const AddContractorDetailsScreen({
    required this.phone,
    required this.otpController,
    required this.location,
    required this.refCode,
    super.key,
  });

  @override
  State<AddContractorDetailsScreen> createState() =>
      _AddContractorDetailsScreenState();
}

class _AddContractorDetailsScreenState
    extends State<AddContractorDetailsScreen> {
  late final TextEditingController contractorPhoneController;
  late final TextEditingController contractorNameController;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    contractorPhoneController = TextEditingController();
    contractorNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    contractorPhoneController.dispose();
    contractorNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          showCustomLoadingDialog(context);
        } else if (state is OtpVerificationNeededState) {
          Navigator.pop(context);
          CustomNavigator.push(
            context: context,
            child: OtpVerificationScreen(
              otpController: widget.otpController,
              location: widget.location,
            ),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * .05),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: screenSize.height * .13),

                  //====================Furnipart Logo====================//
                  Hero(
                    tag: 'turning_point_logo',
                    child: Image.asset(
                      'assets/icons/turning_point_logo_icon.png',
                      width: screenSize.width * .24,
                    ),
                  ),
                  SizedBox(height: screenSize.height * .045),

                  //====================Title====================//
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Sign up to start\nEarning...',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .084,
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * .015),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Join Our Community by Creating\nYour Personalized Account.',
                      style: GoogleFonts.inter(
                        fontSize: screenSize.width * .036,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(135, 135, 135, 1),
                      ),
                    ),
                  ),

                  //====================TextField Segment====================//
                  SizedBox(height: screenSize.height * .028),
                  signUpTextField(
                    controller: contractorNameController,
                    title: 'Contractor Name',
                    icon: Icons.person,
                  ),
                  SizedBox(height: screenSize.height * .03),
                  signUpTextField(
                    controller: contractorPhoneController,
                    title: 'Contractor Mobile Number',
                    icon: Icons.phone,
                    isNumber: true,
                  ),

                  SizedBox(height: screenSize.height * .05),

                  //====================Sign Up Button====================//

                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        authBloc.add(
                          SignUpEvent(
                            phone: widget.phone,
                            contractor: ContractorModel(
                              name: contractorNameController.text.trim(),
                              phone: contractorPhoneController.text.trim(),
                            ),
                            businessName: null,
                            otpController: widget.otpController,
                            refCode: widget.refCode,
                            avoidChecks: true,
                          ),
                        );
                      }
                    },
                    child: Hero(
                      tag: 'sign_in_sign_up_container',
                      child: Container(
                        width: double.infinity,
                        height: screenSize.width * .13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromRGBO(52, 110, 241, 1),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 1,
                              color: Color.fromRGBO(0, 0, 0, .17),
                            ),
                            BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 1,
                              color: Color.fromRGBO(0, 0, 0, .08),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Proceed',
                            style: GoogleFonts.roboto(
                              fontSize: screenSize.width * .036,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenSize.height * .01),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
