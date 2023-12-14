import 'package:flutter/material.dart';
import 'package:turning_point/helper/text_field_segment.dart';

Widget kycPersonalDetails({
  required Size screenSize,
  required TextEditingController nameController,
  required TextEditingController mobileController,
  required TextEditingController emailController,
  required TextEditingController pinController,
}) {
  return Column(
    children: [
      textFieldSegment(
        screenSize: screenSize,
        controller: nameController,
        title: 'Name',
      ),
      SizedBox(height: screenSize.height * .035),
      textFieldSegment(
        screenSize: screenSize,
        controller: mobileController,
        title: 'Mobile Number',
      ),
      SizedBox(height: screenSize.height * .035),
      textFieldSegment(
        screenSize: screenSize,
        controller: emailController,
        title: 'Email',
      ),
      SizedBox(height: screenSize.height * .035),
      textFieldSegment(
        screenSize: screenSize,
        controller: pinController,
        title: 'Pincode',
      ),
    ],
  );
}
