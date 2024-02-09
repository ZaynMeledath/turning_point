// import 'dart:async';
import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/model/contest_model.dart';
import 'package:turning_point/resources/contest_repository.dart';

part 'contest_event.dart';
part 'contest_state.dart';

class ContestBloc extends Bloc<ContestEvent, ContestState> {
  ContestBloc() : super(ContestLoadingState()) {
//====================Contest Load Event====================//
    on<ContestLoadEvent>((event, emit) async {
      emit(ContestLoadingState());

      final contestModelResponse = await ContestRepository.getContests();
      final List<Map<String, String>> timeList = [];
      final secondsLeftList = ContestRepository.getSecondsLeft(
          contestModelList: contestModelResponse.data!);
      log('First for loop starting');
      for (int i = 0; i < contestModelResponse.data!.length; i++) {
        int seconds = secondsLeftList[i];
        int timeInSeconds = (seconds % 60);
        int timeInMinutes = (seconds ~/ 60) % 60;
        int timeInHours = (seconds ~/ 3600) % 24;
        int timeInDays = (seconds ~/ 86400).abs();

        timeList.add({
          'timeInSeconds': timeInSeconds.toString().padLeft(2, '0'),
          'timeInMinutes': timeInMinutes.toString().padLeft(2, '0'),
          'timeInHours': timeInHours.toString().padLeft(2, '0'),
          'timeInDays': timeInDays.toString().padLeft(2, '0'),
        });
      }
      emit(
        ContestLoadedState(
          contestModelList: contestModelResponse.data!,
          timeList: timeList,
          secondsLeftList: secondsLeftList,
        ),
      );
      add(ContestTimerUpdateEvent());
    });

//====================Timer Update Event====================//
    on<ContestTimerUpdateEvent>((event, emit) async {
      if (state.timeList != null && state.secondsLeftList != null) {
        var timeList = state.timeList!;
        var secondsLeftList = state.secondsLeftList!;
        for (int i = 0; i < state.timeList!.length; i++) {
          log('FOR LOOP STARTED');
          int seconds = secondsLeftList[i];

          int timeInSeconds = (seconds % 60);
          int timeInMinutes = (seconds ~/ 60) % 60;
          int timeInHours = (seconds ~/ 3600) % 24;
          int timeInDays = (seconds ~/ 86400).abs();

          timeList[i] = {
            'timeInSeconds': timeInSeconds.toString().padLeft(2, '0'),
            'timeInMinutes': timeInMinutes.toString().padLeft(2, '0'),
            'timeInHours': timeInHours.toString().padLeft(2, '0'),
            'timeInDays': timeInDays.toString().padLeft(2, '0'),
          };
          secondsLeftList[i] -= 1;

          final temp = timeList[i].values.map((e) => e == '00');

          if (!temp.contains(false)) {
            timeList.removeAt(i);
          }
        }

        await Future.delayed(const Duration(seconds: 1));
        if (timeList.isNotEmpty && state is ContestLoadedState) {
          emit(
            ContestLoadedState(
              contestModelList: state.contestModelList,
              timeList: timeList,
              secondsLeftList: secondsLeftList,
            ),
          );
          add(ContestTimerUpdateEvent());
        }
      }
    });

    on<ContestTimerDisposeEvent>((event, emit) {
      log('DISPOSE EXECUTING');
      state.timeList = null;
      state.secondsLeftList = null;
      emit(ContestLoadingState());
      log('DISPOSE EXECUTED');
    });
  }
}
