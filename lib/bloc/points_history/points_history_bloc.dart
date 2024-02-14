import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/model/points_history_model.dart';
import 'package:turning_point/resources/points_history_repository.dart';
import 'package:flutter/foundation.dart' show immutable;

part 'points_history_event.dart';
part 'points_history_state.dart';

class PointsHistoryBloc extends Bloc<PointsHistoryEvent, PointsHistoryState> {
  PointsHistoryBloc() : super(PointsHistoryLoadingState()) {
    on<PointsHistoryLoadEvent>((event, emit) async {
      final pointsHistoryModelResponse =
          await PointsHistoryRespository.getPointsHistory();

      if (pointsHistoryModelResponse.data == null) {
        return emit(NoPointsHistoryState());
      }
      emit(PointsHistoryLoadedState(pointsHistoryModelResponse.data));
    });
  }
}

final pointsHistoryBloc = PointsHistoryBloc();
