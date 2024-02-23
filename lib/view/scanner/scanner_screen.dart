import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:turning_point/bloc/home/home_bloc.dart';
import 'package:turning_point/bloc/scanner/scanner_bloc.dart';
import 'package:turning_point/dialog/show_scanner_coupon_dialog.dart';
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
      backgroundColor: Colors.black,
      body: BlocConsumer<ScannerBloc, ScannerState>(
        listener: (context, state) {
          if (state is ScannerCodeDetectedState) {
            switch (state.couponModel!.message) {
              case 'Coupon Applied':
                showScannerCouponDialog(
                  context: context,
                  iconPath: 'assets/images/points_received_dialog_image.png',
                  title: 'Coupon Applied',
                  content:
                      '${state.couponModel!.points} points has been credited to your account',
                  buttonTitle: 'OK',
                  scannerController: _scannerController,
                );
                break;
              case 'Better luck next time':
                showScannerCouponDialog(
                  context: context,
                  iconPath: 'assets/images/points_received_dialog_image.png',
                  title: 'Better Luck Next Time',
                  content: 'You are gonna be lucky next time',
                  buttonTitle: 'OK',
                  scannerController: _scannerController,
                );
                break;
              case 'Coupon already applied':
                showScannerCouponDialog(
                  context: context,
                  iconPath: 'assets/images/points_received_dialog_image.png',
                  title: 'Coupon Already Applied',
                  content: 'Coupon is already applied',
                  buttonTitle: 'OK',
                  scannerController: _scannerController,
                );

              default:
                showScannerCouponDialog(
                  context: context,
                  iconPath: 'assets/icons/kyc_declined_icon.png',
                  title: 'Something Went Wrong',
                  content:
                      'Something went wrong while connecting to the server',
                  buttonTitle: 'OK',
                  scannerController: _scannerController,
                );
                break;
            }
          }
        },
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

                    onDetect: (capture) {
                      _scannerController.stop();
                      scannerBloc.add(ScannerCodeDetectEvent(capture: capture));
                    },
                  );
                },
              ),

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
