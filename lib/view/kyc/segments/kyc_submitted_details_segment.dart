import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/helper/custom_navigator.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/service/api/api_endpoints.dart';
import 'package:turning_point/view/kyc/kyc_screen.dart';

Widget kycSubmittedDetailsSegment({required BuildContext context}) {
  final userModel = profileBloc.state.userModel!;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: realScreenSize.width * .05),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: realScreenSize.width * .008),
            Text(
              'Personal Details',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .05,
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(16, 16, 16, 1),
              ),
            ),
            SizedBox(width: screenSize.width * .01),
            GestureDetector(
              onTap: () {
                CustomNavigator.pushReplacement(
                  context: context,
                  child: const KycScreen(),
                );
              },
              child: Icon(
                Icons.edit_square,
                size: screenSize.width * .04,
                color: Colors.lightBlue,
              ),
            ),
          ],
        ),
        SizedBox(height: screenSize.height * .018),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: realScreenSize.width * .04,
            vertical: realScreenSize.width * .02,
          ),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(247, 250, 252, 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //====================Title Row====================//
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .034,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: screenSize.height * .015),
                  Text(
                    'Mobile Number',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .034,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: screenSize.height * .015),
                  Text(
                    'Email',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .034,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: screenSize.height * .015),
                  Text(
                    'Pincode',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .034,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: screenSize.height * .015),
                  Text(
                    'Bank Account Name',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .034,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: screenSize.height * .015),
                  Text(
                    'Bank Account Number',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .034,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: screenSize.height * .015),
                  Text(
                    'Bank IFSC',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .034,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(width: screenSize.width * .15),
              //====================Details Row====================//
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userModel.name.toString(),
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .034,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: screenSize.height * .015),
                  Text(
                    userModel.phone.toString(),
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .034,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: screenSize.height * .015),
                  Text(
                    userModel.email.toString(),
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .034,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: screenSize.height * .015),
                  Text(
                    userModel.pincode.toString(),
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .034,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: screenSize.height * .015),
                  Text(
                    userModel.bankDetails![0].accountName.toString(),
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .034,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: screenSize.height * .015),
                  Text(
                    userModel.bankDetails![0].accountNo.toString(),
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .034,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: screenSize.height * .015),
                  Text(
                    userModel.bankDetails![0].ifsc.toString(),
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .034,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        //====================ID Card Image====================//
        SizedBox(height: screenSize.height * .025),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: realScreenSize.width * .008),
          child: Text(
            'ID Card Image',
            style: GoogleFonts.roboto(
              fontSize: screenSize.width * .041,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: screenSize.height * .014),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: realScreenSize.width * .008),
            Image.network(
              '${ApiEndpoints.uploads}/${userModel.idFrontImage.toString()}',
              width: screenSize.width * .45,
            ),
            SizedBox(width: screenSize.width * .06),
            Image.network(
              '${ApiEndpoints.uploads}/${userModel.idBackImage.toString()}',
              width: screenSize.width * .45,
            ),
          ],
        ),
      ],
    ),
  );
}
