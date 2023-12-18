import 'package:flutter/material.dart';
import 'package:turning_point/helper/custom_app_bar.dart';
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
            customAppBar(
              context: context,
              screenSize: screenSize,
              title: 'Points',
            ),

//====================Body Segment====================//
            SizedBox(height: screenSize.height * .015),
            availablePointsSegment(screenSize: screenSize, context: context),
            SizedBox(height: screenSize.height * .024),
            pointsHistorySegment(screenSize: screenSize),
          ],
        ),
      ),
    );
  }
}
