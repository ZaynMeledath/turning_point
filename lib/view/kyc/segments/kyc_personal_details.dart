import 'package:flutter/material.dart';
import 'package:turning_point/view/kyc/segments/kyc_text_field_segment.dart';

Widget kycPersonalDetails({
  required Size screenSize,
  required TextEditingController nameController,
  required TextEditingController mobileController,
  required TextEditingController emailController,
  required TextEditingController pinController,
}) {
  return ListView(
    children: [
      SizedBox(height: screenSize.height * .016),
      kycTextFieldSegment(
        controller: nameController,
        title: 'Name',
      ),
      SizedBox(height: screenSize.height * .035),
      kycTextFieldSegment(
        controller: mobileController,
        title: 'Mobile Number',
        isNum: true,
      ),
      SizedBox(height: screenSize.height * .035),
      kycTextFieldSegment(
        controller: emailController,
        title: 'Email',
        isEmail: true,
      ),
      SizedBox(height: screenSize.height * .035),
      kycTextFieldSegment(
        controller: pinController,
        title: 'Pincode',
        isNum: true,
      ),
    ],
  );
}
