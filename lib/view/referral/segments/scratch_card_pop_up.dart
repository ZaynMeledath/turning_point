import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratcher/scratcher.dart';

Future<void> scratchCardPopUp(BuildContext context) {
  final scratchKey = GlobalKey<ScratcherState>();
  return showDialog(
      context: context,
      builder: (context) => Center(
            child: Scratcher(
                key: scratchKey,
                brushSize: 50,
                threshold: 70,
                image: Image.asset(
                  'assets/images/star_pattern.png',
                  fit: BoxFit.fill,
                ),
                onThreshold: () {
                  scratchKey.currentState
                      ?.reveal(duration: const Duration(milliseconds: 500));
                },
                child: Container(
                  width: 270,
                  height: 300,
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
                      const SizedBox(height: 15),
                      Text(
                        'You have Won!',
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                )),
          )).then((value) => value ?? 'false');
}
