import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/bloc/kyc/kyc_bloc.dart';
import 'package:turning_point/utilities/screen_size.dart';
import 'package:turning_point/view/kyc/segments/kyc_id_capture_container.dart';

Widget kycIdProof() {
  return BlocBuilder<KycBloc, KycState>(
    builder: (context, state) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * .041),
        child: ListView(
          children: [
            Text(
              'Upload your Identity Document and click a Selfie',
              style: GoogleFonts.roboto(
                fontSize: screenSize.width * .03,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: screenSize.height * .02),
            SizedBox(
              width: screenSize.width * .641 + 2,
              height: screenSize.width * .421 + 2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: screenSize.width * .641,
                    height: screenSize.width * .421,
                    margin: EdgeInsets.symmetric(
                        horizontal: screenSize.width * .02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 3,
                        color: const Color.fromRGBO(235, 235, 235, 1),
                      ),
                    ),
                    child: Center(
                      child: state.idDisplayImage != null
                          ? Image.file(state.idDisplayImage!)
                          : Image.asset(
                              'assets/icons/kyc_id_proof_main_icon.png',
                              width: screenSize.width * .19,
                              height: screenSize.width * .156,
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
                    left: screenSize.width * .02,
                    child: Container(
                      height: screenSize.width * .25,
                      width: 6,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    right: screenSize.width * .02,
                    child: Container(
                      height: screenSize.width * .25,
                      width: 6,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenSize.height * .01),
            Padding(
              padding: EdgeInsets.only(right: realScreenSize.width * .12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    focusColor: Colors.blue.shade100,
                    enableFeedback: true,
                    onTap: () => kycBloc.add(KycIdResetEvent()),
                    child: Text(
                      'Reset',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .031,
                        color: const Color.fromRGBO(0, 99, 255, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenSize.height * .013),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (state.idFrontImage == null) {
                        kycBloc.add(KycIdUpdateEvent());
                      }
                    },
                    child: kycIdCaptureContainer(
                      title: 'Front',
                      isActive: state.idFrontImage == null,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (state.idFrontImage != null &&
                          state.idBackImage == null) {
                        kycBloc.add(KycIdUpdateEvent());
                      }
                    },
                    child: kycIdCaptureContainer(
                      title: 'Back',
                      isActive: state.idFrontImage != null &&
                          state.idBackImage == null,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: screenSize.height * .013),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (state.idFrontImage != null &&
                        state.idBackImage != null &&
                        state.selfie == null) {
                      kycBloc.add(KycSelfieUpdateEvent());
                    }
                  },
                  child: kycIdCaptureContainer(
                    title: 'Selfie',
                    isSelfie: true,
                    isActive: state.idFrontImage != null &&
                        state.idBackImage != null &&
                        state.selfie == null,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
