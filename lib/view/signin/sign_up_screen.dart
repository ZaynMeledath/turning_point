// ignore_for_file: use_build_context_synchronously

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/auth/auth_bloc.dart';
import 'package:turning_point/bloc/contractor/contractor_bloc.dart';
import 'package:turning_point/constants/constants.dart';
import 'package:turning_point/dialog/show_animated_generic_dialog.dart';
import 'package:turning_point/dialog/show_custom_loading_dialog.dart';
import 'package:turning_point/dialog/show_loading_dialog.dart';
import 'package:turning_point/helper/custom_navigator.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_radio_button.dart';
import 'package:turning_point/resources/location_repository.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/view/signin/add_contractor_details_screen.dart';
import 'package:turning_point/view/signin/otp_verification_screen.dart';

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
  bool isReferralExpanded = false;

  late final TextEditingController phoneController;
  late final TextEditingController businessController;
  late final TextEditingController searchController;
  late final TextEditingController otpController;
  late final TextEditingController referralController;
  final GlobalKey<FormState> _formKey = GlobalKey();
  Position? location;

  @override
  void initState() {
    isContractor = widget.isContractor;
    contractorBloc.add(ContractorLoadEvent(isSignUp: true));
    phoneController = TextEditingController();
    businessController = TextEditingController();
    searchController = TextEditingController();
    otpController = TextEditingController();
    referralController = TextEditingController();
    getLocation();

    super.initState();
  }

  void getLocation() async {
    location = await LocationRepository.getCurrentLocation();
  }

  @override
  void dispose() {
    phoneController.dispose();
    businessController.dispose();
    searchController.dispose();
    referralController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          showCustomLoadingDialog(context);
        } else if (state is SignUpState && state.exception != null) {
          Navigator.pop(context);
          showAnimatedGenericDialog(
            context: context,
            iconPath: 'assets/lottie/gear_error_animation.json',
            title: 'Something Went Wrong',
            content:
                'Something went wrong while accessing\nthe server. Please try after sometime',
            buttonTitle: 'OK',
            iconWidth: screenSize.width * .2,
          );
        } else if (state is PhoneNumberExistsState) {
          Navigator.pop(context);
          showAnimatedGenericDialog(
            context: context,
            iconPath: 'assets/icons/kyc_declined_icon.png',
            title: 'Phone Already Exists',
            content: 'The number you are trying to register already exists.',
            buttonTitle: 'OK',
          );
        } else if (state is OtpVerificationNeededState) {
          Navigator.pop(context);
          CustomNavigator.push(
            context: context,
            child: OtpVerificationScreen(
              otpController: otpController,
              location: location,
            ),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ContractorBloc, ContractorState>(
            builder: (context, contractorState) {
              switch (contractorState) {
                case ContractorLoadingState():
                  return const Center(
                    child: CircularProgressIndicator.adaptive(
                      strokeWidth: 5,
                    ),
                  );

                case ContractorLoadedState():
                  // phoneController.text = authBloc.state.phone ?? '';
                  // businessController.text = authBloc.state.businessName ?? '';

                  return SingleChildScrollView(
                    reverse: true,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * .05),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // SizedBox(height: screenSize.height * .082),
                            SizedBox(height: screenSize.height * .11),
                            //====================Furnipart Logo====================//
                            Hero(
                              tag: 'turning_point_logo',
                              child: Image.asset(
                                'assets/icons/turning_point_logo_icon.png',
                                width: screenSize.width * .24,
                              ),
                            ),
                            SizedBox(height: screenSize.height * .04),

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
                              controller: phoneController,
                              title: 'Mobile Number',
                              isNumber: true,
                              icon: Icons.phone,
                            ),
                            SizedBox(height: screenSize.height * .03),
                            isContractor
                                ? signUpTextField(
                                    controller: businessController,
                                    title: 'Business Name',
                                    icon: Icons.business,
                                  )
                                : contractorDropDownContainer(
                                    searchController: searchController),
                            // SizedBox(height: screenSize.height * .02),

                            // GestureDetector(
                            //   onTap: () {
                            //     setState(() {
                            //       isReferralExpanded = !isReferralExpanded;
                            //     });
                            //   },
                            //   child: ExpansionPanelList(
                            //     expandedHeaderPadding: EdgeInsets.zero,
                            //     elevation: 0,
                            //     expansionCallback: (panelIndex, isExpanded) {
                            //       setState(() {
                            //         isReferralExpanded = isExpanded;
                            //       });
                            //     },
                            //     children: [
                            //       ExpansionPanel(
                            //         isExpanded: isReferralExpanded,
                            //         backgroundColor: Colors.white,
                            //         headerBuilder: (context, isExpanded) {
                            //           return Align(
                            //             alignment: Alignment.centerLeft,
                            //             child: Padding(
                            //               padding: EdgeInsets.only(
                            //                   left: screenSize.width * .015),
                            //               child: const Text(
                            //                   'Referral Code (Optional)'),
                            //             ),
                            //           );
                            //         },
                            //         body: Column(
                            //           children: [
                            //             const SizedBox(height: 5),
                            //             signUpTextField(
                            //               controller: referralController,
                            //               title: 'Referral Code',
                            //               icon: Icons
                            //                   .connect_without_contact_rounded,
                            //               isNull: true,
                            //             ),
                            //           ],
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            // Visibility(
                            //   visible: !isReferralExpanded,
                            //   child: Container(
                            //     height: 1,
                            //     color: Colors.black.withOpacity(.2),
                            //     margin: EdgeInsets.symmetric(
                            //         horizontal: screenSize.width * .01),
                            //   ),
                            // ),
                            Visibility(
                              visible: !isContractor,
                              child: Column(
                                children: [
                                  SizedBox(height: screenSize.height * .028),

                                  //====================Radio Button====================//
                                  GestureDetector(
                                    onTap: () => contractorBloc.add(
                                      ContractorNotListedEvent(),
                                    ),
                                    child: signUpRadioButtonSegment(
                                      title: 'My contractor is not listed',
                                      isActive:
                                          contractorState.contractorNotListed ==
                                              true,
                                    ),
                                  ),
                                  SizedBox(height: screenSize.height * .02),
                                  GestureDetector(
                                    onTap: () => contractorBloc.add(
                                      HaveNoContractorEvent(),
                                    ),
                                    child: signUpRadioButtonSegment(
                                      title: "I don't have a contractor",
                                      isActive:
                                          contractorState.haveNoContractor ==
                                              true,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: screenSize.height * .05,
                            ),

                            //====================Sign Up Button====================//

                            GestureDetector(
                              onTap: () async {
                                final status =
                                    _formKey.currentState!.validate();
                                if (status) {
                                  if (contractorState.contractorNotListed ==
                                      true) {
                                    showLoadingDialog(context: context);
                                    final phoneExists =
                                        await UserRepository.checkPhoneNumber(
                                            phoneController.text.trim());
                                    if (phoneExists) {
                                      Navigator.pop(context);
                                      showAnimatedGenericDialog(
                                        context: context,
                                        iconPath:
                                            'assets/icons/kyc_declined_icon.png',
                                        title: 'Phone Already Exists',
                                        content:
                                            'The number you are trying to register already exists.',
                                        buttonTitle: 'OK',
                                      );
                                    } else {
                                      Navigator.pop(context);
                                      CustomNavigator.push(
                                        context: context,
                                        child: AddContractorDetailsScreen(
                                          phone: phoneController.text.trim(),
                                          otpController: otpController,
                                          location: location,
                                          refCode:
                                              referralController.text.trim(),
                                        ),
                                      );
                                    }
                                    return;
                                  }
                                  if (widget.isContractor) {
                                    authBloc.add(
                                      SignUpEvent(
                                        phone: phoneController.text,
                                        contractor: null,
                                        businessName:
                                            businessController.text.trim(),
                                        otpController: otpController,
                                        refCode: referralController.text.trim(),
                                      ),
                                    );
                                  } else {
                                    authBloc.add(
                                      SignUpEvent(
                                        phone: phoneController.text,
                                        contractor: contractorBloc.state
                                                        .contractorNotListed !=
                                                    true &&
                                                contractorBloc.state
                                                        .haveNoContractor !=
                                                    true
                                            ? contractorBloc.state.contractor
                                            : DEFAULT_CONTRACTOR,
                                        businessName: null,
                                        otpController: otpController,
                                        refCode: referralController.text.trim(),
                                      ),
                                    );
                                  }
                                }
                                // else {
                                //   showGenericDialog(
                                //     context: context,
                                //     title: 'Fill All Details',
                                //     content:
                                //         'Please fill all the required details to continue',
                                //     options: {'Dismiss': null},
                                //   );
                                // }
                              },
                              child: Hero(
                                tag: 'sign_in_sign_up_container',
                                child: Container(
                                  width: double.infinity,
                                  height: screenSize.width * .13,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color:
                                        const Color.fromRGBO(52, 110, 241, 1),
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
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }

//   bool validate() {
//     if (widget.isContractor) {
//       if (phoneController.text.isNotEmpty &&
//           businessController.text.isNotEmpty &&
//           phoneController.text.length > 9 &&
//           businessController.text.length > 1) {
//         return true;
//       } else {
//         return false;
//       }
//     } else {
//       if ((contractorBloc.state.contractorNotListed == true ||
//               contractorBloc.state.selectedContractor != null) &&
//           phoneController.text.isNotEmpty &&
//           phoneController.text.length > 9) {
//         return true;
//       } else {
//         return false;
//       }
//     }
//   }
}
