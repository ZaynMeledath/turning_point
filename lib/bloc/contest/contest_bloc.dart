import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/model/contest_model.dart';
import 'package:turning_point/resources/contest_repository.dart';

part 'contest_event.dart';
part 'contest_state.dart';

class ContestBloc extends Bloc<ContestEvent, ContestState> {
  ContestBloc() : super(ContestInitialState()) {
    on<ContestLoadEvent>((event, emit) async {
      emit(ContestLoadingState());
      final contestModelResponse = await ContestRepository.getContests();

      emit(ContestLoadedState(contestModelList: contestModelResponse.data!));
    });
  }
}
