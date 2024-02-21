import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/model/contest_model.dart';
import 'package:turning_point/resources/contest_repository.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/service/Exception/user_exceptions.dart';

part 'join_contest_event.dart';
part 'join_contest_state.dart';

class JoinContestBloc extends Bloc<JoinContestEvent, JoinContestState> {
  JoinContestBloc() : super(JoinContestInitialState()) {
    on<JoinContestEvent>((event, emit) async {
      try {
        final userModelResponse = UserRepository.getUserFromPreference()!;
        if (userModelResponse.data!.points! >= event.contestModel.points!) {
          await ContestRepository.joinContest(event.contestModel.id!);
          userModelResponse.data!.points =
              userModelResponse.data!.points! - event.contestModel.points!;
          profileBloc.add(ProfileLoadEvent());
          UserRepository.addUserToPreference(userModelResponse);
          emit(ContestJoinedState(event.contestModel));
        } else {
          emit(
            JoinContestErrorState(
              InsufficientBalanceToJoinContestException(),
            ),
          );
        }
      } catch (e) {
        emit(JoinContestErrorState(Exception(e)));
      }
    });
  }
}

final joinContestBloc = JoinContestBloc();