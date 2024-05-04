import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/my_app_bar.dart';
import 'package:turning_point/model/referral_model.dart';
import 'package:turning_point/view/redeem/redeem_screen.dart';

class RewardsHistoryScreen extends StatelessWidget {
  final ReferralModel referralModel;
  const RewardsHistoryScreen({
    required this.referralModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        context: context,
        title: 'Rewards History',
        backgroundColor: const Color(0xff0054b4),
        foregroundColor: Colors.white,
      ),
      body: Expanded(
        child: LiquidPullToRefresh(
          onRefresh: () => handleRefresh(),
          animSpeedFactor: 2,
          height: 45,
          showChildOpacityTransition: false,
          color: const Color.fromRGBO(89, 165, 255, 1),
          backgroundColor: Colors.white,
          child: GridView.builder(
            padding: EdgeInsets.only(
              top: screenSize.height * .025,
              left: screenSize.width * .055,
              right: screenSize.width * .055,
            ),
            itemCount: referralModel.appliedRewards!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: screenSize.width * .05,
              crossAxisSpacing: screenSize.width * .055,
              mainAxisExtent: screenSize.width * .5,
            ),
            itemBuilder: (context, index) {
              final rewardPoint = referralModel.appliedRewards![index].value!;
              return Padding(
                padding: EdgeInsets.only(bottom: screenSize.height * .025),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * .02,
                    vertical: screenSize.width * .015,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      Colors.blue.shade900,
                      Colors.blue.shade400,
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Colors.blue.shade200,
                        blurStyle: BlurStyle.outer,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/purple_gift_box.png',
                      ),
                      SizedBox(height: screenSize.height * .017),
                      Text(
                        'You have Won\n$rewardPoint points',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: screenSize.width * .036,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(.9),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
