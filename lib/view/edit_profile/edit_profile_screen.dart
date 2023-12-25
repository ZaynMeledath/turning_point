// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  late final TextEditingController _mobileController;
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
    _mobileController = TextEditingController();
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
    _mobileController.dispose();
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
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
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
                screenSize: screenSize,
              ),
              SizedBox(height: screenSize.height * .038),

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
                          isActive: activeRadioNumber == 1 ? true : false,
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
                          isActive: activeRadioNumber == 2 ? true : false,
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
              SizedBox(height: screenSize.height * .015),
//====================TextField Segment====================//
              textFieldSegment(
                screenSize: screenSize,
                controller: _nameController,
                title: 'Name',
              ),
              SizedBox(height: screenSize.height * .037),
              textFieldSegment(
                screenSize: screenSize,
                controller: _mobileController,
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
                title: isContractor ? 'Business Name' : 'Contractor Name',
              ),
              SizedBox(height: screenSize.height * .037),
              textFieldSegment(
                screenSize: screenSize,
                controller: _emailController,
                title: 'Email',
              ),
              SizedBox(height: screenSize.height * .065),
              Container(
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ));
  }
}
