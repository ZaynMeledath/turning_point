// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/bloc/sign_up/contractor_bloc.dart';
import 'package:turning_point/helper/widget/custom_app_bar.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_radio_button.dart';
import 'package:turning_point/view/edit_profile/segments/edit_profile_picture_segment.dart';
import 'package:turning_point/view/edit_profile/segments/text_field_segment.dart';
import 'package:photo_view/photo_view.dart';
import 'package:turning_point/view/signin/sign_up_screen.dart';

part 'profile_picture_view.dart';

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
  late final TextEditingController _emailController;
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
    _emailController = TextEditingController();
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
    _emailController.dispose();
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
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          // listener: (context, state) {
          //   if (state is ProfileLoadedState) {
          //     // final closeDialog = _closeDialogHandle;
          //     // if (state.isLoading && closeDialog == null) {
          //     //   _closeDialogHandle = showLoadingDialog(context: context);
          //     // } else if (!state.isLoading && closeDialog != null) {
          //     //   closeDialog();
          //     //   _closeDialogHandle = null;
          //     // }
          //     if (state.isLoading) {
          //       Overlay.of(context).insert(loadingOverlay);
          //     } else {
          //       loadingOverlay.remove();
          //     }
          //   }
          // },
          builder: (context, state) {
            switch (state) {
              case ProfileLoadingState():
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );

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
                if (!state.isContractor) {
                  contractorBloc.add(ContractorLoadEvent());
                }
                _addressController.text = state.userModel.businessName ?? '';
                _businessController.text = state.userModel.businessName ?? '';
                _nameController.text = state.userModel.name!;
                _phoneController.text = state.userModel.phone!;
                _emailController.text = state.userModel.email!;

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
                          userModel: state.userModel,
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
                                      return Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: screenSize.width,
                                          height: screenSize.height * .052,
                                          margin: EdgeInsets.symmetric(
                                              horizontal:
                                                  screenSize.width * .041),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(-1.5, 1.5),
                                                blurRadius: 1.5,
                                                color: Colors.black
                                                    .withOpacity(.2),
                                                blurStyle: BlurStyle.normal,
                                              ),
                                            ],
                                            border: Border.all(
                                              width: .8,
                                              color: const Color.fromRGBO(
                                                  214, 214, 214, 1),
                                            ),
                                          ),
                                        ),
                                      );
                                    case ContractorLoadedState():
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                screenSize.width * .041),
                                        child: contractorDropDownContainer(
                                          searchController: _searchController,
                                        ),
                                      );
                                  }
                                },
                              ),
                        SizedBox(height: screenSize.height * .037),
                        textFieldSegment(
                          screenSize: screenSize,
                          controller: _emailController,
                          title: 'Email',
                        ),

                        SizedBox(height: screenSize.height * .051),
                        GestureDetector(
                          onTap: () {
                            profileBloc.add(
                              ProfileUpdateEvent(
                                isContractor: state.isContractor,
                                name: _nameController.text.trim(),
                                phone: _phoneController.text.trim(),
                                address: _addressController.text.trim(),
                                businessName: _businessController.text.trim(),
                                email: _emailController.text.trim(),
                              ),
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
}
