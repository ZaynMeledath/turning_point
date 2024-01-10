import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeState(0, null)) {
//====================Home Pressed Event====================//
    on<HomePressedEvent>((event, emit) {
      emit(HomeState(0, state));
    });

//====================Rewards Pressed Event====================//
    on<RewardsPressedEvent>((event, emit) {
      emit(RewardsState(1, state));
    });

//====================Scanner Pressed Event====================//
    on<ScannerPressedEvent>((event, emit) {
      emit(ScannerState(2, state));
    });

//====================Lucky Draw Event====================//
    on<LuckyDrawPressedEvent>((event, emit) {
      emit(LuckyDrawState(3, state));
    });

//====================Connect Pressed Event====================//
    on<ConnectPressedEvent>((event, emit) {
      emit(ConnectState(state.currentIndex, state));
    });
  }
}
