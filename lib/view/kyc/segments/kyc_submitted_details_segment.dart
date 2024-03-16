import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/helper/screen_size.dart';

Widget kycSubmittedDetailsSegment() {
  final userModel = profileBloc.state.userModel!;
  return SingleChildScrollView(
    child: Column(
      children: [
        Text(
          'Submitted Details',
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .05,
            fontWeight: FontWeight.bold,
            color: const Color.fromRGBO(16, 16, 16, 1),
          ),
        ),
        SizedBox(height: screenSize.height * .018),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
//====================Title Row====================//
            Column(
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

//====================Details Row====================//
            Column(
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
        SizedBox(height: screenSize.height * .02),
        Text(
          'ID Card Image',
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .041,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Image.network(),
      ],
    ),
  );
}
