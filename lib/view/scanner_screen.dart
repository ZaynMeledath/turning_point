import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:turning_point/helper/screen_size.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(1),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * .051,
            vertical: screenSize.height * .055,
          ),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Place the QR Code\nwithin the box to scan',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: screenSize.width * .041,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: screenSize.height * .08),
                Container(
                  width: screenSize.width * .84,
                  height: screenSize.height * .5,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                  ),
                  child: MobileScanner(
                    overlay: Stack(
                      children: [
                        Positioned(
                          left: -15,
                          top: -15,
                          child: Container(
                            width: screenSize.width * .83 + 30,
                            height: screenSize.height * .5 + 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              border: Border.all(
                                width: 35,
                                color: const Color.fromRGBO(35, 35, 35, 0.6),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onDetect: (barcodes) {},
                  ),
                ),
                // Expanded(
                //   child: Align(
                //     alignment: Alignment.bottomCenter,
                //     child: Container(
                //       width: screenSize.width * .4,
                //       height: screenSize.width * .12,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(16),
                //         color: const Color.fromRGBO(0, 99, 255, 1),
                //       ),
                //       child: Center(
                //         child: Text(
                //           'Scan',
                //           style: GoogleFonts.roboto(
                //             fontSize: screenSize.width * .036,
                //             fontWeight: FontWeight.w600,
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
