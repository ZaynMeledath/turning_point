import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:turning_point/model/carpenters_list_model.dart';
import 'package:turning_point/resources/user_repository.dart';

part 'carpenter_event.dart';
part 'carpenter_state.dart';

class CarpenterBloc extends Bloc<CarpenterEvent, CarpenterState> {
  CarpenterBloc() : super(CarpenterInitialState()) {
    //====================Carpenters Load Event====================//
    on<CarpenterLoadEvent>((event, emit) async {
      try {
        emit(CarpenterLoadingState());
        final carpentersListModelResponse =
            await UserRepository.getAllCarpentersByContractorName();
        if (carpentersListModelResponse != null &&
            carpentersListModelResponse.data != null) {
          return emit(CarpenterLoadedState(
              carpentersListModel: carpentersListModelResponse.data!));
        } else {
          return emit(CarpenterLoadErrorState());
        }
      } catch (_) {
        return emit(CarpenterLoadErrorState());
      }
    });
  }
}

final carpenterBloc = CarpenterBloc();
