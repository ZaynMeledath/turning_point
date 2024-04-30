import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:turning_point/bloc/home/home_bloc.dart';
import 'package:turning_point/bloc/rewards/rewards_bloc.dart';
import 'package:turning_point/constants/constants.dart';
import 'package:turning_point/model/contest_model.dart';
import 'package:turning_point/resources/contest_repository.dart';

part 'lucky_draw_event.dart';
part 'lucky_draw_state.dart';

class LuckyDrawBloc extends Bloc<LuckyDrawEvent, LuckyDrawState> {
  bool isWinnerDisplayEventActive = false;
  LuckyDrawBloc() : super(LuckyDrawLoadingState()) {
//====================Lucky Draw Load Event====================//
    on<LuckyDrawLoadEvent>((event, emit) async {
      try {
        if (state.timeMap == null && state.secondsLeft == null) {
          final contestModelResponse =
              await ContestRepository.getCurrentContest();
          if (contestModelResponse.data != null &&
              contestModelResponse.data!.isNotEmpty) {
            Map<String, String> timeMap = {};
            int secondsLeft = ContestRepository.getLuckyDrawSecondsLeft(
                contestModel: contestModelResponse.data![0]);

            final prizeCount = contestModelResponse.data![0].prizeArr!.length;

            if (secondsLeft <= LUCKY_DRAW_WINNER_DISPLAY_DELAY * prizeCount) {
              return add(
                  LuckyDrawWinnersDisplayEvent(secondsLeft: secondsLeft));
            }
            secondsLeft =
                secondsLeft - (prizeCount * LUCKY_DRAW_WINNER_DISPLAY_DELAY);

            int timeInSeconds = (secondsLeft % 60);
            int timeInMinutes = (secondsLeft ~/ 60) % 60;
            int timeInHours = (secondsLeft ~/ 3600) % 24;
            int timeInDays = (secondsLeft ~/ 86400).abs();

            timeMap = {
              'timeInSeconds': timeInSeconds.toString().padLeft(2, '0'),
              'timeInMinutes': timeInMinutes.toString().padLeft(2, '0'),
              'timeInHours': timeInHours.toString().padLeft(2, '0'),
              'timeInDays': timeInDays.toString().padLeft(2, '0'),
            };

            emit(
              LuckyDrawLoadedState(
                contestModel: contestModelResponse.data![0],
                timeMap: timeMap,
                secondsLeft: secondsLeft,
              ),
            );
            add(LuckyDrawTimerUpdateEvent());
          } else {
            emit(
              LuckyDrawLoadedState(
                contestModel: null,
                timeMap: null,
                secondsLeft: null,
              ),
            );
          }
        }
      } catch (e) {
        return emit(
          LuckyDrawLoadedState(
            contestModel: null,
            timeMap: null,
            secondsLeft: null,
          ),
        );
      }
    });

//====================Timer Update Event====================//
    on<LuckyDrawTimerUpdateEvent>((event, emit) async {
      if (state.timeMap != null && state.secondsLeft != null) {
        var timeMap = state.timeMap!;
        var secondsLeft = state.secondsLeft!;

        int timeInSeconds = (secondsLeft % 60);
        int timeInMinutes = (secondsLeft ~/ 60) % 60;
        int timeInHours = (secondsLeft ~/ 3600) % 24;
        int timeInDays = (secondsLeft ~/ 86400).abs();

        timeMap = {
          'timeInSeconds': timeInSeconds.toString().padLeft(2, '0'),
          'timeInMinutes': timeInMinutes.toString().padLeft(2, '0'),
          'timeInHours': timeInHours.toString().padLeft(2, '0'),
          'timeInDays': timeInDays.toString().padLeft(2, '0'),
        };
        secondsLeft -= 1;

        final temp = timeMap.values.map((e) => e == '00');

        // if the timer is 00
        if (!temp.contains(false)) {
          //Do some animations to display the winners
          timeMap.clear();

          return add(
            LuckyDrawWinnersDisplayEvent(
              secondsLeft: state.contestModel!.prizeArr!.length *
                  LUCKY_DRAW_WINNER_DISPLAY_DELAY,
            ),
          );
        }

        if (timeMap.isNotEmpty && state is LuckyDrawLoadedState) {
          emit(
            LuckyDrawLoadedState(
              contestModel: state.contestModel,
              timeMap: timeMap,
              secondsLeft: secondsLeft,
            ),
          );
          await Future.delayed(const Duration(seconds: 1));
          return add(LuckyDrawTimerUpdateEvent());
        } else {
          return;
        }
      }
    });

//====================Lucky Draw Winners Display Event====================//
    on<LuckyDrawWinnersDisplayEvent>((event, emit) {
      isWinnerDisplayEventActive = true;
      rewardsBloc.add(RewardsLoadEvent());
      final secondsLeft = event.secondsLeft - 1;

      int timeInSeconds = secondsLeft % 60;
      int timeInMinutes = secondsLeft ~/ 60;

      final timeMap = {
        'timeInSeconds': timeInSeconds.toString().padLeft(2, '0'),
        'timeInMinutes': timeInMinutes.toString().padLeft(2, '0'),
      };

      final prizeIndex = (secondsLeft ~/ LUCKY_DRAW_WINNER_DISPLAY_DELAY);

      emit(LuckyDrawWinnersDisplayState(
        contestModel: state.contestModel,
        timeMap: timeMap,
        secondsLeft: secondsLeft,
        prizeIndex: prizeIndex,
        scaleAnimate: state.scaleAnimate,
        opacityAnimate: state.opacityAnimate,
        repeatedScaleAnimate: state.repeatedScaleAnimate,
      ));
      return add(LuckyDrawWinnersDisplayTimerEvent());
    });

//====================Lucky Draw Winners Timer Update Event====================//
    on<LuckyDrawWinnersDisplayTimerEvent>((event, emit) async {
      if (state.timeMap != null && state.secondsLeft != null) {
        var timeMap = state.timeMap!;
        var secondsLeft = state.secondsLeft!;

        int timeInSeconds = (secondsLeft % 60);
        int timeInMinutes = (secondsLeft ~/ 60);

        timeMap = {
          'timeInSeconds': timeInSeconds.toString().padLeft(2, '0'),
          'timeInMinutes': timeInMinutes.toString().padLeft(2, '0'),
        };

        final temp = timeMap.values.map((e) => e == '00');

        // if the timer is 00
        if (!temp.contains(false)) {
          timeMap.clear();
          state.timeMap = null;
          state.secondsLeft = null;
          await Future.delayed(const Duration(seconds: 2));
          isWinnerDisplayEventActive = false;
          Future.delayed(const Duration(milliseconds: 100), () {
            add(LuckyDrawLoadEvent());
            if (homeBloc.state.currentIndex == 3) {
              return homeBloc.add(TriggerEvent(1));
            } else {
              return;
            }
          });
        }

        if (timeMap.isNotEmpty && state is LuckyDrawWinnersDisplayState) {
          final prizeIndex = (secondsLeft ~/ LUCKY_DRAW_WINNER_DISPLAY_DELAY);

          await Future.delayed(const Duration(seconds: 1));
          if (state.scaleAnimate != true) {
            emit(
              LuckyDrawWinnersDisplayState(
                contestModel: state.contestModel,
                timeMap: timeMap,
                secondsLeft: secondsLeft,
                prizeIndex: prizeIndex,
                scaleAnimate: true,
                opacityAnimate: false,
                repeatedScaleAnimate: state.repeatedScaleAnimate,
              ),
            );
          }

          if (secondsLeft % (LUCKY_DRAW_WINNER_DISPLAY_DELAY) == 0) {
            emit(
              LuckyDrawWinnersDisplayState(
                contestModel: state.contestModel,
                timeMap: timeMap,
                secondsLeft: secondsLeft,
                prizeIndex: state.prizeIndex,
                scaleAnimate: false,
                repeatedScaleAnimate: false,
                opacityAnimate: true,
              ),
            );
          }
          secondsLeft -= 1;

          emit(
            LuckyDrawWinnersDisplayState(
              contestModel: state.contestModel,
              timeMap: timeMap,
              secondsLeft: secondsLeft,
              prizeIndex: prizeIndex,
              scaleAnimate: state.scaleAnimate,
              opacityAnimate: state.opacityAnimate,
              repeatedScaleAnimate:
                  state.repeatedScaleAnimate == true ? false : true,
            ),
          );

          return add(LuckyDrawWinnersDisplayTimerEvent());
        } else {
          return;
        }
      }
    });

//====================Timer Dispose Event====================//
    on<LuckyDrawTimerDisposeEvent>((event, emit) {
      state.contestModel = null;
      state.timeMap = null;
      state.secondsLeft = null;
      emit(LuckyDrawLoadingState());
    });
  }
}

final luckyDrawBloc = LuckyDrawBloc();
