import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:turning_point/model/contest_model.dart';
import 'package:turning_point/resources/contest_repository.dart';

part 'lucky_draw_event.dart';
part 'lucky_draw_state.dart';

class LuckyDrawBloc extends Bloc<LuckyDrawEvent, LuckyDrawState> {
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
            final secondsLeft = ContestRepository.getLuckyDrawSecondsLeft(
                contestModel: contestModelResponse.data![0]);

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
          // return add(LuckyDrawWinnersDisplayEvent());
        }

        if (timeMap.isEmpty) {
          emit(LuckyDrawLoadingState());
          return add(LuckyDrawLoadEvent());
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

//====================Winners Display Event====================//
    // on<LuckyDrawWinnersDisplayEvent>((event, emit) {
    //   emit(Lucky);
    // });

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
