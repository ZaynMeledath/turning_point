// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/helper/widget/custom_app_bar.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_radio_button.dart';
import 'package:turning_point/view/edit_profile/segments/edit_profile_picture_segment.dart';
import 'package:turning_point/view/edit_profile/segments/text_field_segment.dart';

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
  late bool isContractor;
  int activeRadioNumber = 1;

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
    isContractor = activeRadioNumber == 1 ? true : false;

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

    // _nameNode.dispose();
    // _mobileNode.dispose();
    // _addressNode.dispose();
    // _businessNode.dispose();
    // _emailNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(ProfileLoadEvent());
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            switch (state) {
              case ProfileLoadingState():
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );

              case ProfileLoadedState():
                _addressController.text = state.userModel.shopName ?? '';
                _businessController.text = state.userModel.shopName ?? '';
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
                          imagePath: state.userModel.image!,
                        ),
                        SizedBox(height: screenSize.height * .045),

                        //====================Radio Buttons====================//
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isContractor = false;
                                  activeRadioNumber = 1;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  customRadioButton(
                                    isActive:
                                        activeRadioNumber == 1 ? true : false,
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
                            SizedBox(width: screenSize.width * .08),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isContractor = true;
                                  activeRadioNumber = 2;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  customRadioButton(
                                    isActive:
                                        activeRadioNumber == 2 ? true : false,
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
                        textFieldSegment(
                          screenSize: screenSize,
                          controller: _businessController,
                          title: isContractor
                              ? 'Business Name'
                              : 'Contractor Name',
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
                            context.read<ProfileBloc>().add(
                                  ProfileUpdateEvent(
                                    isContractor: isContractor,
                                    name: _nameController.text,
                                    phone: _phoneController.text,
                                    address: _addressController.text,
                                    businessName: _businessController.text,
                                    email: _emailController.text,
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
            }
          },
        ),
      ),
    );
  }
}
