import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/auth/auth_bloc.dart';
import 'package:turning_point/bloc/sign_up/contractor_bloc.dart';
import 'package:turning_point/dialog/show_loading_dialog.dart';
import 'package:turning_point/helper/custom_navigator.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_radio_button.dart';
import 'package:turning_point/view/signin/otp_verfication_screen.dart';

part 'segments/sign_up_text_field.dart';
part 'segments/sign_up_radio_button_segment.dart';
part 'segments/contractor_drop_down_container.dart';

class SignUpScreen extends StatefulWidget {
  final bool isContractor;
  const SignUpScreen({
    required this.isContractor,
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late bool isContractor;
  int activeRadioNumber = 1;
  String? selectedValue;

  late final TextEditingController mobileController;
  late final TextEditingController businessController;
  late final TextEditingController searchController;

  @override
  void initState() {
    isContractor = widget.isContractor;
    contractorBloc.add(ContractorLoadEvent());
    mobileController = TextEditingController();
    businessController = TextEditingController();
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    mobileController.dispose();
    businessController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          showLoadingDialog(context: context);
        } else if (state is OtpVerificationNeededState) {
          Navigator.pop(context);
          CustomNavigator.push(
            context: context,
            child: const OtpVerificationScreen(),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ContractorBloc, ContractorState>(
            builder: (context, state) {
              switch (state) {
                case ContractorLoadingState():
                  return const Center(
                    child: CircularProgressIndicator.adaptive(
                      strokeWidth: 5,
                    ),
                  );
                case ContractorLoadedState():
                  return SingleChildScrollView(
                    reverse: true,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * .05),
                      child: Column(
                        children: [
                          SizedBox(height: screenSize.height * .13),

                          //====================Furnipart Logo====================//
                          Hero(
                            tag: 'furnipart_logo',
                            child: Image.asset(
                              'assets/images/furnipart_logo.png',
                              width: screenSize.width * .32,
                              height: screenSize.height * .086,
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
                              controller: mobileController,
                              title: 'Mobile Number',
                              iconPath: 'assets/icons/sign_up_phone_icon.png'),
                          SizedBox(height: screenSize.height * .03),
                          isContractor
                              ? signUpTextField(
                                  controller: businessController,
                                  title: 'Business Name',
                                  iconPath:
                                      'assets/icons/sign_up_phone_icon.png')
                              : contractorDropDownContainer(
                                  searchController: searchController),
                          Visibility(
                            visible: !isContractor,
                            child: Column(
                              children: [
                                SizedBox(height: screenSize.height * .035),

                                //====================Radio Button====================//
                                signUpRadioButtonSegment(
                                    title: 'My contractor is not listed',
                                    isActive: false),
                                SizedBox(height: screenSize.height * .02),
                                signUpRadioButtonSegment(
                                    title: "I don't have a contractor",
                                    isActive: false),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: screenSize.height * .05,
                          ),

                          //====================Sign Up Button====================//

                          GestureDetector(
                            onTap: () {
                              if (state.contractorString != null) {
                                authBloc.add(
                                  SignUpEvent(
                                    phone: mobileController.text,
                                    contractor: state.contractor,
                                    businessName: null,
                                  ),
                                );
                              } else {
                                authBloc.add(
                                  SignUpEvent(
                                    phone: mobileController.text,
                                    contractor: null,
                                    businessName:
                                        businessController.text.trim(),
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
                                    'Sign Up',
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
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
