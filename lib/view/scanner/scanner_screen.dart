import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:turning_point/bloc/home/home_bloc.dart';
import 'package:turning_point/bloc/scanner/scanner_bloc.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'dart:math' as math;

part 'segments/scanner_overlay.dart';
part 'segments/scanner_error_widget.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  late final MobileScannerController _scannerController;
  final ValueNotifier<bool> permissionNotifier = ValueNotifier(false);

  @override
  void initState() {
    checkPermission();
    _scannerController = MobileScannerController();
    super.initState();
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  void checkPermission() async {
    permissionNotifier.value = await Permission.camera.isGranted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ScannerBloc, ScannerState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              //====================Scanner====================//
              ValueListenableBuilder(
                  valueListenable: permissionNotifier,
                  builder: (context, value, child) {
                    return MobileScanner(
                      errorBuilder: (context, exception, child) =>
                          scannerErrorWidget(context),
                      controller: _scannerController,
                      scanWindow: Rect.fromPoints(
                        Offset(screenSize.width * .15, screenSize.height * .25),
                        Offset(screenSize.width * .85, screenSize.height * .54),
                      ),

                      //====================Scanner Overlay====================//
                      overlay: const ScannerOverlay(
                        overlayColour: Color.fromRGBO(35, 35, 35, 0.6),
                      ),
                      onDetect: (barcodes) {},
                    );
                  }),

              //====================Instruction Text====================//
              Positioned(
                top: screenSize.height * .08 + 50,
                child: Text(
                  permissionNotifier.value
                      ? 'Place the QR Code\nwithin the box to scan'
                      : '',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: screenSize.width * .041,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
