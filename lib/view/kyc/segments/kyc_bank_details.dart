import 'package:flutter/material.dart';
import 'package:turning_point/view/kyc/segments/kyc_text_field_segment.dart';

Widget kycBankDetails({
  required Size screenSize,
  required TextEditingController accNameController,
  required TextEditingController accNumController,
  required TextEditingController confirmAccNumController,
  required TextEditingController ifscController,
}) {
  return Column(
    children: [
      kycTextFieldSegment(
        screenSize: screenSize,
        controller: accNameController,
        title: 'Account Name',
      ),
      SizedBox(height: screenSize.height * .03),
      kycTextFieldSegment(
        screenSize: screenSize,
        controller: accNumController,
        title: 'Account Number',
      ),
      SizedBox(height: screenSize.height * .03),
      kycTextFieldSegment(
        screenSize: screenSize,
        controller: confirmAccNumController,
        title: 'Confirm Account Number',
      ),
      SizedBox(height: screenSize.height * .03),
      kycTextFieldSegment(
        screenSize: screenSize,
        controller: ifscController,
        title: 'IFSC',
      ),
    ],
  );
}
