import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget rewardsTabBar({
  required Size screenSize,
  required TabController tabController,
}) {
  return Container(
    clipBehavior: Clip.antiAlias,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(18),
        topRight: Radius.circular(18),
      ),
    ),
    child: Container(
      width: screenSize.width * .8,
      height: screenSize.width * .09,
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * .003,
        vertical: screenSize.width * .005,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: screenSize.width * .1,
        vertical: screenSize.width * .015,
      ),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(245, 246, 255, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TabBar(
        controller: tabController,
        dividerHeight: 0,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 4,
              color: Color.fromRGBO(0, 0, 0, .1),
            ),
          ],
        ),
        labelColor: const Color.fromRGBO(0, 0, 0, 1),
        tabs: [
          Text(
            'Current Month',
            style: GoogleFonts.roboto(
              fontSize: screenSize.width * .031,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            'Previous Month',
            style: GoogleFonts.roboto(
              fontSize: screenSize.width * .031,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    ),
  );
}
