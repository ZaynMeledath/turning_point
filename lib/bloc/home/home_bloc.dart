import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(TriggeredState(0)) {
//====================Home Pressed Event====================//
    on<TriggerEvent>((event, emit) {
      if (event.index == 4) {
        emit(ConnectState());
      } else {
        emit(TriggeredState(event.index));
      }
    });
  }
}

final homeBloc = HomeBloc();
