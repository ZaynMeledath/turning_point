import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(TriggeredState(0)) {
//====================Home Pressed Event====================//
    on<TriggerEvent>((event, emit) {
      if (event.index == 4) {
        return emit(ConnectState(state.currentIndex));
      } else {
        return emit(TriggeredState(event.index));
      }
    });
  }
  @override
  void onChange(Change<HomeState> change) {
    log('CURRENT STATE : ${change.currentState}');
    log('NEXT STATE: ${change.nextState}');
    super.onChange(change);
  }
}

final homeBloc = HomeBloc();
