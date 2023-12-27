import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/widget/custom_app_bar.dart';
import 'package:turning_point/helper/screen_size.dart';

class AllGiftsScreen extends StatefulWidget {
  const AllGiftsScreen({super.key});

  @override
  State<AllGiftsScreen> createState() => _AllGiftsScreenState();
}

class _AllGiftsScreenState extends State<AllGiftsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 204, 0, 1),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            customAppBar(
              context: context,
              title: 'Gifts',
              foregroundColor: Colors.black.withOpacity(.8),
            ),
            Positioned(
              bottom: -screenSize.width * .82,
              width: screenSize.width * 1.3,
              height: screenSize.width * 1.3,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(226, 181, 54, 1),
                    ),
                    BoxShadow(
                      color: Color.fromRGBO(209, 99, 1, 1),
                      offset: Offset(0, 4),
                      blurRadius: 121,
                      spreadRadius: 4,
                      blurStyle: BlurStyle.outer,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -screenSize.width * .7,
              width: screenSize.width * .8,
              height: screenSize.width * .8,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(226, 181, 54, 1),
                    ),
                    BoxShadow(
                      color: Color.fromRGBO(209, 99, 1, .6),
                      offset: Offset(0, 4),
                      blurRadius: 121,
                      spreadRadius: 47,
                      blurStyle: BlurStyle.normal,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenSize.height * .067),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * .045,
                      vertical: screenSize.width * .045,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * .031,
                      vertical: screenSize.width * .018,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white.withOpacity(.9),
                      // gradient: LinearGradient(
                      //   colors: [
                      //     const Color.fromRGBO(255, 221, 84, 1),
                      //     Colors.white.withOpacity(.9),
                      //   ],
                      //   begin: Alignment.topCenter,
                      //   end: Alignment.bottomCenter,
                      // ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/red_gift_box.png',
                          width: screenSize.width * .12,
                        ),
                        SizedBox(height: screenSize.width * .015),
                        Text(
                          'Gift Name',
                          style: GoogleFonts.roboto(
                            fontSize: screenSize.width * .038,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: screenSize.width * .025,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
