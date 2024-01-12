import 'package:flutter_bloc/flutter_bloc.dart';

part 'contractor_event.dart';
part 'contractor_state.dart';

class ContractorBloc extends Bloc<ContractorEvent, ContractorState> {
  ContractorBloc() : super(ContractorSelectedState(null)) {
//====================ContractorSelectedEvent====================//
    on<ContractorSelectedEvent>((event, emit) {
      emit(ContractorSelectedState(event.contractorName));
    });
  }
}
