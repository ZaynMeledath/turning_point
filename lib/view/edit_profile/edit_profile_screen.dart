// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  int selectedValue = 1;

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
    isContractor = selectedValue == 1 ? true : false;

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
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: screenSize.height * .009),

//====================Header Segment====================//
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * .03),
                child: Row(
                  children: [
                    Hero(
                      tag: 'back_button',
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: screenSize.height * .033,
                        ),
                        onPressed: () async {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    SizedBox(width: screenSize.width * .041),
                    Hero(
                      tag: 'edit_profile',
                      child: Text(
                        'Edit Profile',
                        style: GoogleFonts.inter(
                          fontSize: screenSize.width * .041,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
//====================Body Segment====================//
              editProfilePictureSegment(
                context: context,
                screenSize: screenSize,
              ),
              SizedBox(height: screenSize.height * .035),
              Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: selectedValue,
                    activeColor: Colors.red,
                    focusColor: Colors.red,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value!;
                        isContractor = !isContractor;
                      });
                    },
                  ),
                  Radio(
                    value: 2,
                    groupValue: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value!;
                        isContractor = !isContractor;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * .012),
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
                  color: const Color.fromRGBO(13, 153, 255, 1),
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
