import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * .051,
            vertical: screenSize.height * .03,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenSize.height * .22),
              Text(
                'Scan QR Code',
                style: GoogleFonts.roboto(
                    fontSize: screenSize.width * .036,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromRGBO(142, 142, 142, 1)),
              ),
              SizedBox(height: screenSize.height * .005),
              Container(
                width: screenSize.width * .56,
                height: screenSize.width * .56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(.05),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/scanner_screen_image.png',
                    width: screenSize.width * .245,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: screenSize.width * .7,
                    height: screenSize.width * .11,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: const Color.fromRGBO(0, 99, 255, 1),
                    ),
                    child: Center(
                      child: Text(
                        'Scan',
                        style: GoogleFonts.roboto(
                          fontSize: screenSize.width * .036,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
