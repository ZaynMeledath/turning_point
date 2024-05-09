part of '../referral_screen.dart';

Future<void> scratchCardPopUp({
  required BuildContext context,
  required int rewardPoint,
  required int rewardIndex,
}) {
  log('RewardIndex : $rewardIndex');
  final scratchKey = GlobalKey<ScratcherState>();
  return showDialog(
    context: context,
    builder: (context) => Center(
      child: Scratcher(
        key: scratchKey,
        brushSize: 50,
        threshold: 65,
        color: Colors.transparent,
        image: Image.asset(
          'assets/images/star_pattern.png',
          fit: BoxFit.fill,
        ),
        onThreshold: () {
          scratchKey.currentState
              ?.reveal(duration: const Duration(milliseconds: 500));
          referralBloc.add(ReferralRewardScratchedEvent(rewardIndex));
        },
        child: Container(
          width: screenSize.width * .62,
          height: screenSize.height * .345,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
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
                  fontSize: screenSize.width * .05,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  ).then((value) => value ?? 'false');
}
