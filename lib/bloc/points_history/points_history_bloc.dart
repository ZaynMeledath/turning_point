import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/model/points_history_model.dart';
import 'package:turning_point/resources/points_history_repository.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:wakelock_plus/wakelock_plus.dart';

part 'points_history_event.dart';
part 'points_history_state.dart';

class PointsHistoryBloc extends Bloc<PointsHistoryEvent, PointsHistoryState> {
  PointsHistoryBloc() : super(PointsHistoryLoadingState()) {
    on<PointsHistoryLoadEvent>((event, emit) async {
      int page = state.page == null ? 1 : state.page! + 1;

      if (event.isReloading == true) {
        page = 1;
      }

      final pointsHistoryModelResponse =
          await PointsHistoryRespository.getPointsHistory(page: page);

      if (page == 1 &&
          (pointsHistoryModelResponse.data == null ||
              pointsHistoryModelResponse.data!.isEmpty)) {
        WakelockPlus.disable();
        return emit(NoPointsHistoryState());
      }

      if (state.pointsHistoryModel != null &&
          pointsHistoryModelResponse.data != null &&
          event.isReloading != true) {
        state.pointsHistoryModel!.addAll(pointsHistoryModelResponse.data!);
        pointsHistoryModelResponse.data = state.pointsHistoryModel;
      }

      emit(PointsHistoryLoadedState(
        pointsHistoryModel: pointsHistoryModelResponse.data,
        page: page,
      ));
      WakelockPlus.disable();
    });
  }

//====================State Change Logger====================//
  @override
  void onChange(Change<PointsHistoryState> change) {
    log('CURRENT STATE : ${change.currentState}');
    log('NEXT STATE: ${change.nextState}');
    super.onChange(change);
  }
}

final pointsHistoryBloc = PointsHistoryBloc();
