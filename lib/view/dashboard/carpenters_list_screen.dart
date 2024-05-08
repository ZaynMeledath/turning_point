import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_app_bar.dart';

part 'segments/carpenters_header_segment.dart';
part 'segments/carpenter_card.dart';

class CarpentersListScreen extends StatefulWidget {
  const CarpentersListScreen({super.key});

  @override
  State<CarpentersListScreen> createState() => _CarpentersListScreenState();
}

class _CarpentersListScreenState extends State<CarpentersListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          carpentersHeaderSegment(context),
          Expanded(
            child: Container(
              color: const Color.fromRGBO(20, 94, 180, .08),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Positioned(
                  //   top: realScreenSize.height * .02,
                  //   left: -realScreenSize.width * .18,
                  //   child: Container(
                  //     width: realScreenSize.width * .31,
                  //     height: realScreenSize.width * .31,
                  //     decoration: const BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: Color.fromRGBO(222, 234, 244, .8),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           offset: Offset(0, 4),
                  //           blurRadius: 4,
                  //           blurStyle: BlurStyle.inner,
                  //           color: Colors.black26,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Positioned(
                  //   top: realScreenSize.height * .03,
                  //   right: -realScreenSize.width * .4,
                  //   child: Container(
                  //     width: realScreenSize.width * .7,
                  //     height: realScreenSize.width * .7,
                  //     decoration: const BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         color: Color.fromRGBO(222, 234, 244, .8)),
                  //   ),
                  // ),
                  // Positioned(
                  //   bottom: -realScreenSize.width * .9,
                  //   child: Container(
                  //     width: realScreenSize.width * 1.5,
                  //     height: realScreenSize.width * 1.5,
                  //     decoration: const BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: Color.fromRGBO(222, 234, 244, .8),
                  //     ),
                  //   ),
                  // ),
                  LiquidPullToRefresh(
                    height: 50,
                    animSpeedFactor: 2,
                    showChildOpacityTransition: false,
                    color: const Color.fromRGBO(89, 165, 255, 1),
                    backgroundColor: Colors.white,
                    onRefresh: () => _handleRefresh(),
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                        top: screenSize.width * .05,
                        left: screenSize.width * .04,
                        right: screenSize.width * .04,
                      ),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return carpenterCard();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleRefresh() async {}
}
