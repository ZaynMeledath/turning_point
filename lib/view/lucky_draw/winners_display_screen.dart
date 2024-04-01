import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point/bloc/lucky_draw/lucky_draw_bloc.dart';
import 'package:turning_point/bloc/rewards/rewards_bloc.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_loading.dart';
import 'package:turning_point/model/rewards_model.dart';
import 'package:turning_point/service/api/api_endpoints.dart';
import 'package:turning_point/view/lucky_draw/lucky_draw_screen.dart';

part 'segments/winner_details_container.dart';

class WinnersDisplayScreen extends StatefulWidget {
  const WinnersDisplayScreen({super.key});

  @override
  State<WinnersDisplayScreen> createState() => _WinnersDisplayScreenState();
}

class _WinnersDisplayScreenState extends State<WinnersDisplayScreen>
    with TickerProviderStateMixin {
  late AnimationController celebrationLottieController;

  @override
  void initState() {
    celebrationLottieController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool shouldAnimate = true;
    return BlocBuilder<LuckyDrawBloc, LuckyDrawState>(
      builder: (context, luckyDrawState) {
        if (luckyDrawState is LuckyDrawWinnersDisplayState) {
          if (luckyDrawState.scaleAnimate == null ||
              luckyDrawState.scaleAnimate == false) {
            shouldAnimate = true;
          }

          if (luckyDrawState.scaleAnimate == true && shouldAnimate == true) {
            // Future.delayed(const Duration(milliseconds: 200), () {
            celebrationLottieController
              ..reset()
              ..forward();
            shouldAnimate = false;
            // });
          }
          return SizedBox(
            height: screenSize.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  child: Lottie.asset(
                    'assets/lottie/congratulations_animation.json',
                    height: screenSize.height * .25,
                  ),
                ),
                Lottie.asset(
                  'assets/lottie/celebration_animation.json',
                  controller: celebrationLottieController,
                  repeat: false,
                ),
                AnimatedOpacity(
                  opacity: luckyDrawState.opacityAnimate == true ? 0 : 1,
                  duration: const Duration(milliseconds: 800),
                  child: AnimatedScale(
                    scale: luckyDrawState.scaleAnimate == true ? 1 : 0,
                    duration: const Duration(milliseconds: 1800),
                    curve: Curves.bounceOut,
                    child: AnimatedScale(
                      scale: luckyDrawState.repeatedScaleAnimate == true
                          ? 1.05
                          : 1,
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.linear,
                      child: Container(
                        width: screenSize.width * .84,
                        height: screenSize.height * .18,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromRGBO(255, 221, 84, 1),
                              Colors.white.withOpacity(.9),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 1,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: BlocBuilder<RewardsBloc, RewardsState>(
                            builder: (context, rewardsState) {
                          if (rewardsState is RewardsLoadedState) {
                            final rewardsModel =
                                rewardsState.currentRewardsModel!;
                            return winnerDetailsSegment(
                              rewardsModel: rewardsModel,
                              prizeIndex: luckyDrawState.prizeIndex!,
                            );
                          } else {
                            return spinningLinesLoading(
                                color: Colors.white,
                                size: screenSize.height * .05);
                          }
                        }),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: luckyDrawState.prizeIndex != null &&
                      luckyDrawState.prizeIndex! > 0,
                  child: Positioned(
                    top: screenSize.height * .56,
                    right: screenSize.width * .06,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Next Winner\nin',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: screenSize.width * .04,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: screenSize.height * .01),
                          countDownContainer(
                            time: ((luckyDrawState.secondsLeft ?? 0 % 30) + 1)
                                .toString(),
                            title: 'SECONDS',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const LuckyDrawScreen();
        }
      },
    );
  }
}
