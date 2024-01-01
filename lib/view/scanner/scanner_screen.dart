import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/scanner/segments/scanner_overlay.dart';

// part 'segments/scanner_clipper_widget.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  late final MobileScannerController _scannerController;

  @override
  void initState() {
    _scannerController = MobileScannerController();
    super.initState();
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          MobileScanner(
            controller: _scannerController,
            scanWindow: Rect.fromPoints(
              Offset(screenSize.width * .15, screenSize.height * .25),
              Offset(screenSize.width * .85, screenSize.height * .54),
            ),
            overlay: const ScannerOverlay(
              overlayColour: Color.fromRGBO(35, 35, 35, 0.6),
            ),
            onDetect: (barcodes) {},
          ),
          Positioned(
            top: screenSize.height * .08 + 50,
            child: Text(
              'Place the QR Code\nwithin the box to scan',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontSize: screenSize.width * .041,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
