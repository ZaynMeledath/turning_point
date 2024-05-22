import 'dart:async';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/model/contest_model.dart';
import 'package:turning_point/resources/contest_repository.dart';

part 'contest_event.dart';
part 'contest_state.dart';

class ContestBloc extends Bloc<ContestEvent, ContestState> {
  ContestBloc() : super(ContestLoadingState()) {
//====================Contest Load Event====================//
    on<ContestLoadEvent>((event, emit) async {
      try {
        if (state.timeList == null && state.secondsLeftList == null) {
          final contestModelResponse = await ContestRepository.getContests();
          if (contestModelResponse.data != null &&
              contestModelResponse.data!.isNotEmpty) {
            final List<Map<String, String>> timeList = [];
            final secondsLeftList = ContestRepository.getSecondsLeft(
                contestModelList: contestModelResponse.data!);
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
            final entryCount = [];
            for (int i = 0; i < contestModelResponse.data!.length; i++) {
              entryCount.add(1);
            }
            emit(
              ContestLoadedState(
                contestModelList: contestModelResponse.data!,
                timeList: timeList,
                secondsLeftList: secondsLeftList,
                entryCounter: entryCount.map((e) => int.parse('$e')).toList(),
              ),
            );
            add(ContestTimerUpdateEvent());
          } else {
            emit(
              ContestLoadedState(
                contestModelList: null,
                timeList: null,
                secondsLeftList: null,
                entryCounter: [],
              ),
            );
          }
        }
      } catch (e) {
        return emit(
          ContestLoadedState(
            contestModelList: null,
            timeList: null,
            secondsLeftList: null,
            entryCounter: [],
          ),
        );
      }
    });

//====================Timer Update Event====================//
    on<ContestTimerUpdateEvent>((event, emit) async {
      if (state.timeList != null && state.secondsLeftList != null) {
        var timeList = state.timeList!;
        var secondsLeftList = state.secondsLeftList!;
        for (int i = 0; i < state.timeList!.length; i++) {
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
            state.contestModelList!.removeAt(i);
          }
        }
        if (timeList.isEmpty) {
          return emit(
            ContestLoadedState(
              contestModelList: null,
              timeList: null,
              secondsLeftList: null,
              entryCounter: [],
            ),
          );
        }

        if (timeList.isNotEmpty && state is ContestLoadedState) {
          emit(
            ContestLoadedState(
              contestModelList: state.contestModelList,
              timeList: timeList,
              secondsLeftList: secondsLeftList,
              entryCounter: state.entryCounter,
            ),
          );
          await Future.delayed(const Duration(seconds: 1));
          return add(ContestTimerUpdateEvent());
        } else {
          return;
        }
      }
    });

//====================Contest Entry Increment Event Event====================//
    on<ContestEntryIncrementEvent>((event, emit) {
      if (profileBloc.state.userModel!.points! >=
          state.contestModelList![event.contestIndex].points! *
              (state.entryCounter[event.contestIndex] + 1)) {
        state.entryCounter[event.contestIndex] += 1;
        emit(
          ContestLoadedState(
            contestModelList: state.contestModelList,
            timeList: state.timeList,
            secondsLeftList: state.secondsLeftList,
            entryCounter: state.entryCounter,
          ),
        );
      }
    });

//====================Contest Entry Decrement Event Event====================//
    on<ContestEntryDecrementEvent>((event, emit) {
      if (state.entryCounter[event.contestIndex] > 1) {
        state.entryCounter[event.contestIndex] -= 1;
        emit(
          ContestLoadedState(
            contestModelList: state.contestModelList,
            timeList: state.timeList,
            secondsLeftList: state.secondsLeftList,
            entryCounter: state.entryCounter,
          ),
        );
      }
    });

//====================Contest Load Again Event Event (To update the contest list and entry count)====================//
    on<ContestLoadAgainEvent>((event, emit) async {
      final contestModelResponse = await ContestRepository.getContests();
      final List<int> entryCount = [];
      //To make 1 as default value
      for (int i = 0; i < contestModelResponse.data!.length; i++) {
        entryCount.add(1);
      }
      emit(
        ContestLoadedState(
          contestModelList: contestModelResponse.data,
          timeList: state.timeList,
          secondsLeftList: state.secondsLeftList,
          entryCounter: state.entryCounter,
        ),
      );
    });

//====================Timer Dispose Event====================//
    on<ContestTimerDisposeEvent>((event, emit) {
      state.contestModelList = null;
      state.timeList = null;
      state.secondsLeftList = null;
      emit(ContestLoadingState());
    });
  }

//====================State Change Logger====================//
  // @override
  // void onChange(Change<ContestState> change) {
  //   log('CURRENT STATE : ${change.currentState}');
  //   log('NEXT STATE: ${change.nextState}');
  //   super.onChange(change);
  // }
}

final contestBloc = ContestBloc();
