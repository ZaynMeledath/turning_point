part of '../referral_screen.dart';

Future<void> rewardsHistoryModalSheet({
  required BuildContext context,
  required ReferralModel referralModel,
}) {
  return showModalBottomSheet(
    context: context,
    scrollControlDisabledMaxHeightRatio: screenSize.height * .72,
    builder: (_) {
      return Container(
        height: screenSize.height * .72,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.8),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        child: Column(
          children: [
            Container(
              height: screenSize.width * .14,
              decoration: const BoxDecoration(
                color: Color(0xee0054b4),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: Center(
                child: Text(
                  'Rewards History',
                  style: GoogleFonts.inter(
                    fontSize: screenSize.width * .04,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: LiquidPullToRefresh(
                onRefresh: () => handleProfileRefresh(),
                animSpeedFactor: 2,
                height: 45,
                showChildOpacityTransition: false,
                color: const Color.fromRGBO(89, 165, 255, 1),
                backgroundColor: Colors.white,
                child: GridView.builder(
                  padding: EdgeInsets.only(
                    top: screenSize.height * .03,
                    left: screenSize.width * .07,
                    right: screenSize.width * .07,
                  ),
                  itemCount: referralModel.appliedRewards!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: screenSize.width * .05,
                    crossAxisSpacing: screenSize.width * .07,
                    mainAxisExtent: screenSize.width * .48,
                  ),
                  itemBuilder: (context, index) {
                    final rewardPoint =
                        referralModel.appliedRewards![index].value!;
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * .02,
                        vertical: screenSize.width * .01,
                      ),
                      margin: EdgeInsets.only(bottom: screenSize.height * .025),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.shade400,
                            Colors.blue.shade100,
                          ],
                          begin: index % 2 == 0
                              ? Alignment.topLeft
                              : Alignment.topRight,
                          end: index % 2 == 0
                              ? Alignment.bottomRight
                              : Alignment.bottomLeft,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4,
                            color: Colors.black26,
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
                            '$rewardPoint points',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: screenSize.width * .038,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
