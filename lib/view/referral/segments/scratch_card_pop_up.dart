import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratcher/scratcher.dart';
import 'package:turning_point/helper/screen_size.dart';

Future<void> scratchCardPopUp(BuildContext context) {
  final scratchKey = GlobalKey<ScratcherState>();
  return showDialog(
    context: context,
    builder: (context) => Center(
      child: Scratcher(
        key: scratchKey,
        brushSize: 50,
        threshold: 75,
        color: Colors.transparent,
        image: Image.asset(
          'assets/images/star_pattern.png',
          fit: BoxFit.fill,
        ),
        onThreshold: () {
          scratchKey.currentState
              ?.reveal(duration: const Duration(milliseconds: 500));
        },
        child: Container(
          width: screenSize.width * .62,
          height: screenSize.height * .345,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/purple_gift_box.png',
                // width: 87,
                // height: 55,
              ),
              SizedBox(height: screenSize.height * .017),
              Text(
                'You have Won!',
                style: GoogleFonts.roboto(
                  fontSize: screenSize.width * .05,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  ).then((value) => value ?? 'false');
}
