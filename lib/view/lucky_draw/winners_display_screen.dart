import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point/bloc/lucky_draw/lucky_draw_bloc.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/lucky_draw/lucky_draw_screen.dart';

Widget winnersDisplayScreen() {
  return BlocBuilder<LuckyDrawBloc, LuckyDrawState>(
    builder: (context, state) {
      if (state is LuckyDrawWinnersDisplayState) {
        return Center(
          child: Column(
            children: [
              Lottie.asset(
                'assets/lottie/congratulations_animation.json',
                height: screenSize.height * .25,
              ),
              SizedBox(
                height: screenSize.height * .11,
              ),
              AnimatedOpacity(
                opacity: state.opacityAnimate == true ? 0 : 1,
                duration: const Duration(milliseconds: 800),
                child: AnimatedScale(
                  scale: state.scaleAnimate == true ? 1 : 0,
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.bounceOut,
                  child: AnimatedScale(
                    scale: state.repeatedScaleAnimate == true ? 1.05 : 1,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.linear,
                    child: Container(
                      width: screenSize.width * .84,
                      height: screenSize.height * .16,
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
