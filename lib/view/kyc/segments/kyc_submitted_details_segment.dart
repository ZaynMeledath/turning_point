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
                fontSize: screenSize.width * .04,
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(16, 16, 16, 1),
              ),
            ),
          ],
        ),
        SizedBox(height: screenSize.height * .018),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: realScreenSize.width * .04,
            vertical: realScreenSize.height * .016,
          ),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(247, 250, 252, 1),
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //====================Title Row====================//
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .031,
                      color: const Color.fromRGBO(109, 109, 109, 1),
                    ),
                  ),
                  SizedBox(height: screenSize.height * .025),
                  Text(
                    'Mobile Number',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .031,
                      color: const Color.fromRGBO(109, 109, 109, 1),
                    ),
                  ),
                  SizedBox(height: screenSize.height * .025),
                  Text(
                    'Email',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .031,
                      color: const Color.fromRGBO(109, 109, 109, 1),
                    ),
                  ),
                  SizedBox(height: screenSize.height * .025),
                  Text(
                    'Pincode',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .031,
                      color: const Color.fromRGBO(109, 109, 109, 1),
                    ),
                  ),
                  SizedBox(height: screenSize.height * .025),
                  Text(
                    'Bank Account Name',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .031,
                      color: const Color.fromRGBO(109, 109, 109, 1),
                    ),
                  ),
                  SizedBox(height: screenSize.height * .025),
                  Text(
                    'Bank Account Number',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .031,
                      color: const Color.fromRGBO(109, 109, 109, 1),
                    ),
                  ),
                  SizedBox(height: screenSize.height * .025),
                  Text(
                    'Bank IFSC',
                    style: GoogleFonts.roboto(
                      fontSize: screenSize.width * .031,
                      color: const Color.fromRGBO(109, 109, 109, 1),
                    ),
                  ),
                  // SizedBox(height: screenSize.height * .025),
                ],
              ),

              //====================Details Row====================//
              userModel.bankDetails != null && userModel.bankDetails!.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userModel.name.toString(),
                          style: GoogleFonts.roboto(
                            fontSize: screenSize.width * .031,
                            color: const Color.fromRGBO(109, 109, 109, 1),
                          ),
                        ),
                        SizedBox(height: screenSize.height * .025),
                        Text(
                          userModel.phone.toString(),
                          style: GoogleFonts.roboto(
                            fontSize: screenSize.width * .031,
                            color: const Color.fromRGBO(109, 109, 109, 1),
                          ),
                        ),
                        SizedBox(height: screenSize.height * .025),
                        Text(
                          userModel.email.toString(),
                          style: GoogleFonts.roboto(
                            fontSize: screenSize.width * .031,
                            color: const Color.fromRGBO(109, 109, 109, 1),
                          ),
                        ),
                        SizedBox(height: screenSize.height * .025),
                        Text(
                          userModel.pincode.toString(),
                          style: GoogleFonts.roboto(
                            fontSize: screenSize.width * .031,
                            color: const Color.fromRGBO(109, 109, 109, 1),
                          ),
                        ),
                        SizedBox(height: screenSize.height * .025),
                        Text(
                          userModel.bankDetails![0].accountName.toString(),
                          style: GoogleFonts.roboto(
                            fontSize: screenSize.width * .031,
                            color: const Color.fromRGBO(109, 109, 109, 1),
                          ),
                        ),
                        SizedBox(height: screenSize.height * .025),
                        Text(
                          userModel.bankDetails![0].accountNo.toString(),
                          style: GoogleFonts.roboto(
                            fontSize: screenSize.width * .031,
                            color: const Color.fromRGBO(109, 109, 109, 1),
                          ),
                        ),
                        SizedBox(height: screenSize.height * .025),
                        Text(
                          userModel.bankDetails![0].ifsc.toString(),
                          style: GoogleFonts.roboto(
                            fontSize: screenSize.width * .031,
                            color: const Color.fromRGBO(109, 109, 109, 1),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            left: realScreenSize.width * .04,
            top: realScreenSize.height * .005,
            bottom: realScreenSize.height * .016,
          ),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(247, 250, 252, 1),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
          ),
          child: Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  CustomNavigator.pushReplacement(
                    context: context,
                    child: const KycScreen(),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * .055,
                    vertical: screenSize.width * .007,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 99, 255, .9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Edit',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .028,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
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
              fontSize: screenSize.width * .035,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: screenSize.height * .014),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: realScreenSize.width * .008),
            SizedBox(
              width: screenSize.width * .4,
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.network(
                  '${ApiEndpoints.uploads}/${userModel.idFrontImage.toString()}',
                  // width: screenSize.width * .4,
                ),
              ),
            ),
            SizedBox(width: screenSize.width * .06),
            SizedBox(
              width: screenSize.width * .4,
              child: Image.network(
                '${ApiEndpoints.uploads}/${userModel.idBackImage.toString()}',
                // width: screenSize.width * .4,
              ),
            ),
          ],
        ),
        SizedBox(height: screenSize.height * .015),
      ],
    ),
  );
}
