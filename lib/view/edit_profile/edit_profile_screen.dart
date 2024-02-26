// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/contractor/contractor_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/dialog/show_animated_otp_dialog.dart';
import 'package:turning_point/dialog/show_generic_dialog.dart';
import 'package:turning_point/helper/widget/custom_app_bar.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_radio_button.dart';
import 'package:turning_point/model/contractor_model.dart';
import 'package:turning_point/model/user_model.dart';
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

  // CloseDialog? _closeDialogHandle;

  // late final FocusNode _nameNode;
  // late final FocusNode _mobileNode;
  // late final FocusNode _addressNode;
  // late final FocusNode _businessNode;
  // late final FocusNode _emailNode;

  @override
  void initState() {
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _businessController = TextEditingController();
    _searchController = TextEditingController();

    // _nameNode = FocusNode();
    // _mobileNode = FocusNode();
    // _addressNode = FocusNode();
    // _businessNode = FocusNode();
    // _emailNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _businessController.dispose();
    _searchController.dispose();
    // loadingOverlay.dispose();

    // _nameNode.dispose();
    // _mobileNode.dispose();
    // _addressNode.dispose();
    // _businessNode.dispose();
    // _emailNode.dispose();
    super.dispose();
  }

  // final loadingOverlay = OverlayEntry(builder: (_) {
  //   return Positioned(
  //     left: screenSize.width * .5 - 7,
  //     top: screenSize.height * .25,
  //     child: const CupertinoActivityIndicator(
  //       radius: 12,
  //       color: Color.fromRGBO(0, 99, 255, 1),
  //     ),
  //   );
  // });

  @override
  Widget build(BuildContext context) {
    profileBloc.add(ProfileLoadEvent());
    contractorBloc.add(ContractorLoadEvent());

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileLoadedState && state.verifyOtp == true) {
              showAnimatedOtpDialog(
                context: context,
                phone: _phoneController.text,
              );
            }
          },
          builder: (context, state) {
            switch (state) {
              case ProfileLoadingState():
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );

              case ProfileInactiveState():
                return const ProfileInactiveScreen();

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
                if (!state.isLoading) {
                  _addressController.text = state.userModel!.address ?? '';
                  _businessController.text =
                      state.userModel!.businessName ?? '';
                  _nameController.text = state.userModel!.name!;
                  _phoneController.text = state.userModel!.phone!;
                }

                return SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        customAppBar(
                          context: context,
                          title: 'Edit Profile',
                        ),
                        //====================Body Segment====================//
                        editProfilePictureSegment(
                          context: context,
                          userModel: state.userModel!,
                        ),
                        state.isLoading
                            ? Container(
                                height: screenSize.height * .042,
                                color: Colors.transparent,
                                child: Center(
                                  child: CupertinoActivityIndicator(
                                    radius: screenSize.width * .031,
                                    color: const Color.fromRGBO(0, 99, 255, 1),
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
                                profileBloc.add(ProfileRadioTriggerEvent(
                                    isContractor: true));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  customRadioButton(
                                    isActive: state.isContractor ? true : false,
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
                                    isActive: state.isContractor ? false : true,
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
                        state.isContractor
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
                            email: state.userModel!.email!),

                        SizedBox(height: screenSize.height * .051),
                        GestureDetector(
                          onTap: () {
                            updateProfile(
                              context: context,
                              isContractor: state.isContractor,
                              name: _nameController.text.trim(),
                              phone: _phoneController.text.trim(),
                              address: _addressController.text.trim(),
                              businessName: state.isContractor
                                  ? _businessController.text.trim()
                                  : null,
                              email: state.userModel!.email!,
                              contractor: !state.isContractor
                                  ? contractorBloc.state.contractor
                                  : null,
                              userModel: state.userModel!,
                            );
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
                );
            }
          },
        ),
      ),
    );
  }

  void updateProfile({
    required BuildContext context,
    required bool isContractor,
    required String name,
    required String phone,
    required String address,
    required String? businessName,
    required String email,
    required ContractorModel? contractor,
    required UserModel userModel,
  }) {
    if (validate(isContractor)) {
      profileBloc.add(
        ProfileUpdateEvent(
          isContractor: isContractor,
          name: name,
          phone: phone,
          address: address,
          businessName: businessName,
          email: email,
          contractor: contractor,
        ),
      );
      if (phone != userModel.phone) {
        profileBloc.add(ProfilePhoneUpdateEvent(phone: phone));
      }
    } else {
      showGenericDialog(
        context: context,
        title: 'Incorrect Entry',
        content: 'Please Fill the fields correctly',
        options: {'OK': null},
      );
    }
  }

  bool validate(bool isContractor) {
    if (isContractor) {
      if (_businessController.text.isEmpty) {
        return false;
      }
    }

    if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
      return false;
    } else if (int.tryParse(_phoneController.text) == null ||
        _phoneController.text.length < 10) {
      return false;
    } else {
      return true;
    }
  }
}
