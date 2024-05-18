import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/bloc/contest/contest_bloc.dart';
import 'package:turning_point/bloc/points/points_bloc.dart';
import 'package:turning_point/constants/constants.dart';
import 'package:turning_point/model/contest_model.dart';
import 'package:turning_point/resources/contest_repository.dart';
import 'package:turning_point/resources/user_repository.dart';
import 'package:turning_point/service/Exception/user_exceptions.dart';

part 'join_contest_event.dart';
part 'join_contest_state.dart';

class JoinContestBloc extends Bloc<JoinContestEvent, JoinContestState> {
  JoinContestBloc() : super(JoinContestInitialState()) {
    on<JoinContestEvent>((event, emit) async {
      emit(JoinContestLoadingState());
      try {
        final userModelResponse = UserRepository.getUserFromPreference()!;
        if (userModelResponse.data!.kycStatus == KycStatus.APPROVED) {
          if (userModelResponse.data!.points! >=
              event.contestModel.points! * event.entryCount) {
            await ContestRepository.joinContest(
              id: event.contestModel.id!,
              entryCount: event.entryCount,
            );

            pointsBloc
                .add(PointsLoadEvent(avoidGettingUserFromPreference: true));
            contestBloc.add(ContestLoadAgainEvent());

            return emit(ContestJoinedState(event.contestModel));
          } else {
            return emit(
              JoinContestErrorState(
                InsufficientBalanceToJoinContestException(),
              ),
            );
          }
        } else {
          emit(
            JoinContestErrorState(
              VerificationRequiredToJoinContestException(),
            ),
          );
        }
      } catch (e) {
        emit(
          JoinContestErrorState(Exception(e)),
        );
      }
    });
  }

//====================State Change Logger====================//
  @override
  void onChange(Change<JoinContestState> change) {
    log('CURRENT STATE : ${change.currentState}');
    log('NEXT STATE: ${change.nextState}');
    super.onChange(change);
  }
}

final joinContestBloc = JoinContestBloc();
