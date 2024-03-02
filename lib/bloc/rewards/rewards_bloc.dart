import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show immutable;

part 'rewards_event.dart';
part 'rewards_state.dart';

class RewardsBloc extends Bloc<RewardsEvent, RewardsState> {
  RewardsBloc() : super(RewardsLoadingState()) {
    on<RewardsLoadEvent>((event, emit) {});
  }
}
