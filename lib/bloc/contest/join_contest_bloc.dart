import 'package:flutter_bloc/flutter_bloc.dart';
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
        final userModel = UserRepository.getUserFromPreference()!.data!;
        if (userModel.points! >= event.contestModel.points!) {
          ContestRepository.joinContest(event.contestModel.id!);
          emit(ContestJoinedState());
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
