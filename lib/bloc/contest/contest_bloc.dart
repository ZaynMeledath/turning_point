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
    on<ContestLoadEvent>((event, emit) async {
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
        int timeInDays = (seconds ~/ 86400);

        timeList.add({
          'timeInSeconds': timeInSeconds.toString().padLeft(2, '0'),
          'timeInMinutes': timeInMinutes.toString().padLeft(2, '0'),
          'timeInHours': timeInHours.toString().padLeft(2, '0'),
          'timeInDays': timeInDays.toString().padLeft(2, '0'),
        });
      }

      log('Timer loop starting');

      Timer.periodic(const Duration(seconds: 1), (timer) {
        log('second for loop starting');
        for (int i = 0; i < timeList.length; i++) {
          int seconds = secondsLeftList[i];
          int timeInSeconds = (seconds % 60);
          int timeInMinutes = (seconds ~/ 60) % 60;
          int timeInHours = (seconds ~/ 3600) % 24;
          int timeInDays = (seconds ~/ 86400);

          timeList[i] = {
            'timeInSeconds': timeInSeconds.toString().padLeft(2, '0'),
            'timeInMinutes': timeInMinutes.toString().padLeft(2, '0'),
            'timeInHours': timeInHours.toString().padLeft(2, '0'),
            'timeInDays': timeInDays.toString().padLeft(2, '0'),
          };

          final temp = timeList[i].values.map((e) => e == '00');

          if (!temp.contains(false)) {
            timeList.removeAt(i);
          }
        }
        emit(
          ContestLoadedState(
            contestModelList: contestModelResponse.data!,
            timeList: timeList,
          ),
        );
        if (timeList.isEmpty) {
          timer.cancel();
        }
      });
    });
  }
}
