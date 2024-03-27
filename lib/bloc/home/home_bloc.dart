import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/constants/constants.dart';
import 'package:turning_point/resources/reels_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(TriggeredState(0)) {
//====================Home Pressed Event====================//
    on<TriggerEvent>((event, emit) async {
      if (profileBloc.state.userModel!.role == Role.CARPENTER
          ? event.index == 4
          : event.index == 3) {
        return emit(ConnectState(state.currentIndex));
      } else {
        if (state is! ConnectState &&
            event.index == 0 &&
            state.currentIndex == 0) {
          await ReelsRepository.getReels();
          preloadBloc.add(
            PreloadEvent(
              currentIndex: 0,
              isInitial: true,
              isReloading: true,
            ),
          );
        }
        return emit(TriggeredState(event.index));
      }
    });
  }

//====================State Change Logger====================//
  @override
  void onChange(Change<HomeState> change) {
    log('CURRENT STATE : ${change.currentState}');
    log('NEXT STATE: ${change.nextState}');
    super.onChange(change);
  }
}

final homeBloc = HomeBloc();
