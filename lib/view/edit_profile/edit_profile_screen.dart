// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turning_point/bloc/contractor/contractor_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/dialog/show_animated_generic_dialog.dart';
import 'package:turning_point/dialog/show_animated_otp_dialog.dart';
import 'package:turning_point/dialog/show_edit_profile_dialog.dart';
import 'package:turning_point/helper/widget/my_app_bar.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_radio_button.dart';
import 'package:turning_point/view/edit_profile/segments/edit_profile_picture_segment.dart';
import 'package:turning_point/view/edit_profile/segments/text_field_segment.dart';
import 'package:photo_view/photo_view.dart';
import 'package:turning_point/view/home/profile_inactive_screen.dart';
import 'package:turning_point/view/signin/sign_up_screen.dart';

part 'profile_picture_view.dart';
part 'segments/edit_profile_email_container.dart';
part 'segments/contractor_drop_down_loading_state_container.dart.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _businessController;
  late final TextEditingController _searchController;
  late final TextEditingController otpController;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _businessController = TextEditingController();
    _searchController = TextEditingController();
    otpController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _businessController.dispose();
    _searchController.dispose();
    otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    profileBloc.add(ProfileLoadEvent());
    contractorBloc.add(ContractorLoadEvent(isSignUp: false));

    return Scaffold(
      appBar: myAppBar(
        context: context,
        title: 'Edit Profile',
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoadedState &&
              state.verifyOtp == true &&
              state.exception == null) {
            showAnimatedOtpDialog(
              context: context,
              phone: _phoneController.text,
              otpController: otpController,
            );
          } else if (state is ProfileInactiveState) {
            Navigator.of(context).pushAndRemoveUntil(
              PageTransition(
                child: ProfileInactiveScreen(),
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 1),
              ),
              (_) => false,
            );
          } else if (state is ProfileLoadedState && state.exception != null) {
            showAnimatedGenericDialog(
              context: context,
              iconPath: 'assets/lottie/gear_error_animation.json',
              title: 'Error',
              content: state.exception.toString(),
              buttonTitle: 'Dismiss',
            );
          }
        },
        builder: (context, profileState) {
          switch (profileState) {
            case ProfileLoadingState():
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );

            case ProfileInactiveState():
              return ProfileInactiveScreen();

            case ProfileLoadErrorState():
              return Center(
                child: Text(
                  'Something Went Wrong',
                  style: GoogleFonts.poppins(
                    fontSize: screenSize.width * .05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );

            case ProfileLoadedState():
              if (!profileState.isLoading) {
                _addressController.text =
                    profileState.userModel!.actualAddress ?? '';
                _businessController.text =
                    profileState.userModel!.businessName ?? '';
                _nameController.text = profileState.userModel!.name!;
                _phoneController.text = profileState.userModel!.phone!;
              }

              return SafeArea(
                child: SingleChildScrollView(
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          //====================Body Segment====================//
                          editProfilePictureSegment(
                            context: context,
                            userModel: profileState.userModel!,
                          ),
                          profileState.isLoading
                              ? Container(
                                  height: screenSize.height * .042,
                                  color: Colors.transparent,
                                  child: Center(
                                    child: CupertinoActivityIndicator(
                                      radius: screenSize.width * .031,
                                      color:
                                          const Color.fromRGBO(0, 99, 255, 1),
                                    ),
                                  ),
                                )
                              : SizedBox(height: screenSize.height * .042),

                          //====================Radio Buttons====================//
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  profileBloc.add(
                                    ProfileRadioTriggerEvent(
                                        isContractor: true),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    customRadioButton(
                                      isActive: profileState.isContractorTemp,
                                    ),
                                    SizedBox(width: screenSize.width * .01),
                                    Text(
                                      'Contractor',
                                      style: GoogleFonts.roboto(
                                        fontSize: screenSize.width * .046,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: screenSize.width * .08),
                              GestureDetector(
                                onTap: () {
                                  profileBloc.add(ProfileRadioTriggerEvent(
                                      isContractor: false));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    customRadioButton(
                                      isActive: !profileState.isContractorTemp,
                                    ),
                                    SizedBox(width: screenSize.width * .01),
                                    Text(
                                      'Carpenter',
                                      style: GoogleFonts.roboto(
                                        fontSize: screenSize.width * .046,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenSize.height * .018),
                          //====================TextField Segment====================//
                          textFieldSegment(
                            screenSize: screenSize,
                            controller: _nameController,
                            title: 'Name',
                          ),
                          SizedBox(height: screenSize.height * .037),
                          textFieldSegment(
                            screenSize: screenSize,
                            controller: _phoneController,
                            title: 'Mobile Number',
                            isNumber: true,
                          ),
                          SizedBox(height: screenSize.height * .037),
                          textFieldSegment(
                            screenSize: screenSize,
                            controller: _addressController,
                            title: 'Address',
                          ),

                          SizedBox(height: screenSize.height * .037),
                          profileState.isContractorTemp
                              ? textFieldSegment(
                                  screenSize: screenSize,
                                  controller: _businessController,
                                  title: 'Business Name')
                              : BlocBuilder<ContractorBloc, ContractorState>(
                                  builder: (context, state) {
                                    switch (state) {
                                      case ContractorLoadingState():
                                        return contractorDropDownLoadingStateContainer();
                                      case ContractorLoadedState():
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  screenSize.width * .041),
                                          child: contractorDropDownContainer(
                                            searchController: _searchController,
                                            color: Colors.white,
                                          ),
                                        );
                                    }
                                  },
                                ),
                          SizedBox(height: screenSize.height * .037),
                          editProfileEmailContainer(
                              email: profileState.userModel!.email!),

                          SizedBox(height: screenSize.height * .051),
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                final shouldUpdate =
                                    await showEditProfileDialog(
                                        context: context);
                                if (shouldUpdate == true) {
                                  if (hasChanges(
                                      isContractor:
                                          profileState.isContractorTemp)) {
                                    profileBloc.add(
                                      ProfileUpdateEvent(
                                        isContractor:
                                            profileState.isContractorTemp,
                                        name: _nameController.text.trim(),
                                        phone: _phoneController.text.trim(),
                                        address: _addressController.text.trim(),
                                        businessName: profileState.isContractor
                                            ? _businessController.text.trim()
                                            : null,
                                        email: profileState.userModel!.email!,
                                        contractor: !profileState.isContractor
                                            ? contractorBloc.state.contractor
                                            : null,
                                      ),
                                    );
                                    if (_phoneController.text.trim() !=
                                        profileState.userModel!.phone) {
                                      profileBloc.add(
                                        ProfilePhoneUpdateEvent(
                                          phone: _phoneController.text.trim(),
                                          otpController: otpController,
                                        ),
                                      );
                                    }
                                  }
                                }
                              }
                            },
                            child: Container(
                              width: screenSize.width * .38,
                              height: screenSize.width * .102,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: const Color.fromRGBO(0, 99, 255, 1),
                              ),
                              child: Center(
                                child: Text(
                                  'Save',
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: screenSize.width * .036,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenSize.height * .023),
                        ],
                      ),
                    ),
                  ),
                ),
              );
          }
        },
      ),
    );
  }

  bool hasChanges({required bool isContractor}) {
    final userModel = profileBloc.state.userModel!;
    if (_nameController.text.trim() != userModel.name ||
            _phoneController.text.trim() != userModel.phone ||
            _addressController.text.trim() != userModel.actualAddress ||
            isContractor
        ? _businessController.text.trim() != userModel.businessName
        : (contractorBloc.state.contractor!.name !=
                userModel.contractor!.name ||
            contractorBloc.state.contractor!.businessName !=
                userModel.contractor!.businessName)) {
      return true;
    }
    return false;
  }
}
