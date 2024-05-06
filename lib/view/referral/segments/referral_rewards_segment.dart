part of '../referral_screen.dart';

Future<void> handleRefresh() async {
  referralBloc.add(ReferralLoadEvent());
}

Widget referralRewardsSegment({
  required BuildContext context,
  required ReferralModel referralModel,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: screenSize.height * .025),
    child: Column(
      children: [
        //---------------Scrath Cards---------------//
        referralModel.pendingRewards != null &&
                referralModel.pendingRewards!.isNotEmpty
            ? Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.only(top: screenSize.height * .025),
                  itemCount: referralModel.pendingRewards!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: screenSize.height * .025),
                    child: GestureDetector(
                      onTap: () => scratchCardPopUp(
                        context: context,
                        rewardPoint:
                            referralModel.pendingRewards![index].value!,
                        rewardIndex: index,
                      ),
                      child: Image.asset(
                        'assets/images/star_pattern.png',
                      ),
                    ),
                  ),
                ),
              )
            : LiquidPullToRefresh(
                onRefresh: () => handleRefresh(),
                animSpeedFactor: 2,
                height: 45,
                showChildOpacityTransition: false,
                color: const Color.fromRGBO(89, 165, 255, 1),
                backgroundColor: Colors.white,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: screenSize.height * .1),
                        Lottie.asset(
                          'assets/lottie/no_data_animation.json',
                          width: screenSize.width * .4,
                        ),
                        Text(
                          'Earn Points to show the history',
                          style: GoogleFonts.inter(
                            fontSize: screenSize.width * .04,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(.75),
                          ),
                        ),
                        SizedBox(height: screenSize.height * .1),
                      ],
                    ),
                  ),
                ),
              ),

        //---------------See Rewards History--------------//
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                rewardsHistoryModalSheet(
                  context: context,
                  referralModel: referralModel,
                );
              },
              child: Container(
                width: screenSize.width * .84,
                height: screenSize.height * .055,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x16000000),
                      offset: Offset(1, 1),
                      blurRadius: 4,
                    ),
                    BoxShadow(
                      color: Color(0x16000000),
                      offset: Offset(-1, -1),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(width: screenSize.width * .019),
                    Image.asset(
                      'assets/images/purple_gift_box.png',
                      width: screenSize.width * .085,
                    ),
                    SizedBox(width: screenSize.width * .019),
                    Text(
                      'See Reward History',
                      style: GoogleFonts.roboto(
                        fontSize: screenSize.width * .036,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff0054b4),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding:
                              EdgeInsets.only(right: screenSize.width * .036),
                          child: const Icon(
                            Icons.keyboard_arrow_up_rounded,
                            color: Color(0xff263238),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
