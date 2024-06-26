// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:turning_point/bloc/home/home_bloc.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
import 'package:turning_point/bloc/scanner/scanner_bloc.dart';
import 'package:turning_point/dialog/show_loading_dialog.dart';
import 'package:turning_point/dialog/show_scanner_coupon_dialog.dart';
import 'package:turning_point/utils/screen_size.dart';

import 'dart:math' as math;

import 'package:wakelock_plus/wakelock_plus.dart';

part 'segments/scanner_overlay.dart';
part 'segments/scanner_error_widget.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  late final TextEditingController couponController;
  bool shouldScan = true;

  @override
  void initState() {
    couponController = TextEditingController();
    couponController.addListener(() {
      if (couponController.text.isNotEmpty) {
        setState(() {
          shouldScan = false;
        });
      } else {
        setState(() {
          shouldScan = true;
        });
      }
    });
    // getLocation();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (preloadBloc.state.controllers.isNotEmpty) {
      preloadBloc.pauseCurrentController();
    }
    preloadBloc.add(ReelsScreenToggleEvent(isReelsVisible: false));
    disableWakeLock();
    super.didChangeDependencies();
  }

  void disableWakeLock() {
    setState(() {
      WakelockPlus.disable();
    });
  }

  // void getLocation() async {
  //   Timer.periodic(const Duration(seconds: 10), (timer) async {
  //     Position? locationData =
  //         await LocationRepository.getLocationInBackground();
  //     if (locationData != null) {
  //       await ApiService().sendRequest(
  //         url: ApiEndpoints.monitorLocation,
  //         requestMethod: RequestMethod.PATCH,
  //         data: {
  //           "coordinates": [
  //             locationData.latitude,
  //             locationData.longitude,
  //           ],
  //         },
  //         isTokenRequired: true,
  //       );
  //     }
  //   });
  // }

  @override
  void dispose() {
    couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (preloadBloc.state.controllers.isNotEmpty) {
      preloadBloc.pauseCurrentController();
    }
    preloadBloc.add(ReelsScreenToggleEvent(isReelsVisible: false));
    return Scaffold(
      body: BlocConsumer<ScannerBloc, ScannerState>(
        listener: (context, state) {
          if (state is ScannerCodeDetectingState) {
            showLoadingDialog(context: context);
          } else if (state is ScannerCodeDetectedState) {
            couponController.clear();
            Navigator.pop(context);
            switch (state.couponModel!.message) {
              case 'Coupon Applied':
                showScannerCouponDialog(
                  context: context,
                  iconPath: 'assets/images/points_received_dialog_image.png',
                  title: 'Coupon Applied',
                  content:
                      '${state.couponModel!.points} points has been credited to your account',
                  buttonTitle: 'OK',
                );
                break;
              case 'Better luck next time':
                showScannerCouponDialog(
                  context: context,
                  iconPath: 'assets/images/points_received_dialog_image.png',
                  title: 'Better Luck Next Time',
                  content: 'You are gonna be lucky next time',
                  buttonTitle: 'OK',
                );
                break;
              case 'Coupon has already been applied':
                showScannerCouponDialog(
                  context: context,
                  iconPath:
                      'assets/lottie/blocks_rotate_and_load_animation.json',
                  title: 'Coupon Already Applied',
                  content: 'Coupon has already been applied',
                  buttonTitle: 'OK',
                );
              case 'Coupon not found':
                showScannerCouponDialog(
                  context: context,
                  iconPath: 'assets/lottie/boat_not_found_animation.json',
                  title: 'Coupon Not Found',
                  content: 'This Coupon is not valid',
                  buttonTitle: 'OK',
                  iconWidth: screenSize.width * .23,
                );
                break;

              default:
                showScannerCouponDialog(
                  context: context,
                  iconPath: 'assets/lottie/gear_error_animation.json',
                  title: 'Something Went Wrong',
                  content:
                      'Something went wrong while connecting to the server',
                  buttonTitle: 'OK',
                  iconWidth: screenSize.width * .2,
                );
                break;
            }
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  SizedBox(height: screenSize.height * .06),
                  Container(
                    width: double.maxFinite,
                    height: screenSize.height * .18,
                    margin: EdgeInsets.symmetric(
                        horizontal: screenSize.width * .036),
                    decoration: BoxDecoration(
                      // color: const Color.fromRGBO(246, 246, 246, 1),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(246, 246, 246, 1),
                          Color.fromRGBO(250, 250, 250, 1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Scan QR Code',
                          style: GoogleFonts.roboto(
                            fontSize: screenSize.width * .06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenSize.height * .01),
                        Text(
                          'Scan QR Code to obtain points',
                          style: GoogleFonts.roboto(
                            fontSize: screenSize.width * .036,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromRGBO(95, 95, 95, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenSize.height * .03),
                  GestureDetector(
                    onTap: () => scannerBloc.scanCoupon(),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Lottie.asset(
                          'assets/lottie/scanner_screen_animation.json',
                          width: screenSize.width * .65,
                        ),
                        Lottie.asset(
                          'assets/lottie/scanner_screen_animation2.json',
                          width: screenSize.width * .65,
                        ),
                        Image.asset(
                          'assets/images/scanner_screen_image.png',
                          width: screenSize.width * .45,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenSize.height * .03),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * .08),
                    child: TextFormField(
                      controller: couponController,
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .031,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter Coupon Code Manually',
                        hintStyle: GoogleFonts.roboto(
                          fontSize: screenSize.width * .031,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * .04,
                        ),
                        filled: true,
                        fillColor: const Color.fromRGBO(242, 242, 242, 1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * .07),
                  GestureDetector(
                    onTap: () async {
                      // await Permission.location.request();
                      // if (await Permission.location.isDenied) {
                      //   await showAnimatedGenericDialog(
                      //     context: context,
                      //     iconPath: 'assets/lottie/location_animation.json',
                      //     title: 'Permission Needed',
                      //     content:
                      //         'Enable location permission to redeem coupon',
                      //     buttons: {
                      //       'Dismiss': () {
                      //         openAppSettings();
                      //         Navigator.pop(context);
                      //       },
                      //     },
                      //   );
                      //   return;
                      // }

                      if (shouldScan) {
                        await scannerBloc.scanCoupon();
                      } else {
                        scannerBloc.add(
                          ScannerCodeDetectEvent(
                            couponId: couponController.text.trim(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: screenSize.width * .35,
                      height: screenSize.height * .052,
                      margin: EdgeInsets.only(bottom: screenSize.height * .03),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 99, 255, 1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          shouldScan ? 'Scan' : 'Submit',
                          style: GoogleFonts.roboto(
                            fontSize: screenSize.width * .051,
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
          );
        },
      ),
    );
  }
}
