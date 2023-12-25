import 'package:flutter/material.dart';
import 'package:turning_point/helper/screen_size.dart';

Widget dashboardDailyContestContainer() {
  return Container(
    width: screenSize.width * .92,
    height: screenSize.height * .2,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(0, 148, 201, 1),
          Color.fromRGBO(39, 137, 172, 1),
        ],
      ),
    ),
    child: Image.asset(
      'assets/images/dashboard_daily_contest.png',
      fit: BoxFit.cover,
    ),
  );
}
