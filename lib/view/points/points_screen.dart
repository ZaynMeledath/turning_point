import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/view/points/segments/available_points_segment.dart';
import 'package:turning_point/view/points/segments/points_history_segment.dart';

class PointsScreen extends StatefulWidget {
  const PointsScreen({super.key});

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
//====================Header Segment with Back Button and Title====================//
            SizedBox(height: screenSize.height * .009),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * .03),
              child: Row(
                children: [
                  Hero(
                    tag: 'back_button',
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: screenSize.height * .033,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(width: screenSize.width * .041),
                  Hero(
                    tag: 'Points',
                    child: Text(
                      'Points',
                      style: GoogleFonts.inter(
                        fontSize: screenSize.width * .041,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),

//====================Body Segment====================//
            SizedBox(height: screenSize.height * .015),
            availablePointsSegment(screenSize: screenSize),
            SizedBox(height: screenSize.height * .024),
            pointsHistorySegment(screenSize: screenSize),
          ],
        ),
      ),
    );
  }
}
