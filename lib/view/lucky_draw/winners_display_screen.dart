import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point/bloc/lucky_draw/lucky_draw_bloc.dart';
import 'package:turning_point/bloc/rewards/rewards_bloc.dart';
import 'package:turning_point/constants/constants.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/helper/widget/custom_loading.dart';
import 'package:turning_point/model/rewards_model.dart';
import 'package:turning_point/service/api/api_endpoints.dart';
import 'package:dotted_border/dotted_border.dart';

part 'segments/winner_details_segment.dart';
part 'segments/winners_display_count_down.dart';

class WinnersDisplayScreen extends StatefulWidget {
  const WinnersDisplayScreen({super.key});

  @override
  State<WinnersDisplayScreen> createState() => _WinnersDisplayScreenState();
}

class _WinnersDisplayScreenState extends State<WinnersDisplayScreen>
    with TickerProviderStateMixin {
  late AnimationController celebrationLottieController;
  bool isAudioPlaying = false;
  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    celebrationLottieController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      rewardsBloc.add(RewardsLoadEvent());
    });
    bool shouldAnimate = true;
    return BlocBuilder<LuckyDrawBloc, LuckyDrawState>(
      builder: (context, luckyDrawState) {
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
        if (luckyDrawState.contestModel != null) {
          if (!isAudioPlaying) {
            isAudioPlaying = true;
            audioPlayer.play(
              AssetSource(
                'sounds/lucky_draw_music.m4a',
              ),
            );
          }
          return SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Column(
              children: [
                SizedBox(height: screenSize.height * .1),
                AnimatedScale(
                  scale: luckyDrawState.repeatedScaleAnimate == true ? 1.05 : 1,
                  duration: const Duration(milliseconds: 800),
                  child: Image.asset(
                    'assets/images/congratulations_image.png',
                    width: screenSize.width * .5,
                  ),
                ),
                SizedBox(height: screenSize.height * .025),
                AnimatedOpacity(
                  opacity: luckyDrawState.opacityAnimate == true ? 0 : 1,
                  duration: const Duration(milliseconds: 800),
                  child: AnimatedScale(
                    scale: luckyDrawState.scaleAnimate == true ? 1 : 0,
                    duration: const Duration(milliseconds: 1000),
                    child: Image.network(
                      luckyDrawState.contestModel!
                          .prizeArr![luckyDrawState.prizeIndex!].image
                          .toString(),
                      width: screenSize.width * .35,
                    ),
                  ),
                ),
                SizedBox(
                  width: realScreenSize.width,
                  height: screenSize.width * .6,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                        top: -screenSize.width * .18,
                        child: Lottie.asset(
                          'assets/lottie/celebration_animation.json',
                          width: screenSize.width,
                          controller: celebrationLottieController,
                          repeat: false,
                          fit: BoxFit.cover,
                        ),
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
                            child: BlocBuilder<RewardsBloc, RewardsState>(
                                builder: (context, rewardsState) {
                              if (rewardsState is RewardsLoadedState) {
                                final rewardsModel =
                                    rewardsState.currentRewardsModel!;
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    winnerDetailsSegment(
                                      rewardsModel: rewardsModel,
                                      prizeIndex: luckyDrawState.prizeIndex!,
                                    ),
                                  ],
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
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: screenSize.height * .03),
                    Text(
                      'Next Winner in',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: screenSize.width * .036,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: screenSize.height * .015),
                    winnersDisplayCountDown(),
                    SizedBox(height: screenSize.height * .01),
                  ],
                ),
              ],
            ),
          );
        } else {
          return spinningLinesLoading(color: Colors.white);
        }
      },
    );
  }
}
