import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/view/kyc/segments/kyc_id_capture_container.dart';

Widget kycIdProof({required Size screenSize}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenSize.width * .041),
    child: Column(
      children: [
        Text(
          'Take a Photo of the Front & Back of your Aadhar Card',
          style: GoogleFonts.roboto(
            fontSize: screenSize.width * .038,
            fontWeight: FontWeight.w300,
          ),
        ),
        SizedBox(height: screenSize.height * .033),
        SizedBox(
          width: screenSize.width * .77 + 2,
          height: screenSize.width * .51 + 2,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: screenSize.width * .77,
                height: screenSize.width * .51,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 3,
                    color: const Color.fromRGBO(212, 231, 255, 1),
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/id_proof_image.png',
                    width: screenSize.width * .66,
                    height: screenSize.width * .4,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: Container(
                  width: screenSize.width * .33,
                  height: 6,
                  color: Colors.white,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: screenSize.width * .33,
                  height: 5,
                  color: Colors.white,
                ),
              ),
              Positioned(
                left: 0,
                child: Container(
                  height: screenSize.width * .25,
                  width: 6,
                  color: Colors.white,
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  height: screenSize.width * .25,
                  width: 6,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenSize.height * .035),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              kycIdCaptureContainer(
                screenSize: screenSize,
                title: 'Front',
                isActive: true,
              ),
              kycIdCaptureContainer(
                screenSize: screenSize,
                title: 'Back',
                isActive: false,
              )
            ],
          ),
        ),
      ],
    ),
  );
}
