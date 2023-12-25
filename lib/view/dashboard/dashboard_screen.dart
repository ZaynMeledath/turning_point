import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_app_bar.dart';
import 'package:turning_point/view/dashboard/segments/contests_participated_container.dart';
import 'package:turning_point/view/dashboard/segments/dashboard_available_balance_container.dart';
import 'package:turning_point/view/dashboard/segments/dashboard_daily_contest_container.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            customAppBar(context: context, title: 'Dashboard'),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * .041),
              child: Column(
                children: [
                  SizedBox(height: screenSize.height * .015),
                  Hero(
                    tag: 'profile_picture',
                    child: CircleAvatar(
                      radius: screenSize.height * .058,
                      backgroundColor: const Color.fromRGBO(225, 225, 225, .3),
                      child: CircleAvatar(
                        radius: (screenSize.height * .058) - 5,
                        backgroundColor:
                            const Color.fromRGBO(225, 225, 225, .6),
                        child: CircleAvatar(
                          radius: (screenSize.height * .058) - 10,
                          foregroundImage:
                              const AssetImage('assets/images/avatar.jpg'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * .02),
                  dashboardAvailableBalanceContainer(context: context),
                  SizedBox(height: screenSize.height * .025),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Activity',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .041,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * .016),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: contestsParticipatedContainer(),
                  ),
                  SizedBox(height: screenSize.height * .018),
                  dashboardDailyContestContainer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
