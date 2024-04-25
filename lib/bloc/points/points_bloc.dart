import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/resources/user_repository.dart';

part 'points_event.dart';
part 'points_state.dart';

class PointsBloc extends Bloc<PointsEvent, PointsState> {
  PointsBloc() : super(InitialPointsState()) {
//====================Points Load Event====================//
    on<PointsLoadEvent>((event, emit) async {
      final userModelResponse = await UserRepository.getUserById(
          avoidGettingFromPreference:
              event.avoidGettingUserFromPreference ?? false);
      emit(
        PointsLoadedState(points: userModelResponse!.data!.points),
      );
    });
  }
}

final pointsBloc = PointsBloc();
