import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/model/contractor_model.dart';
import 'package:turning_point/resources/user_repository.dart';

part 'contractor_event.dart';
part 'contractor_state.dart';

class ContractorBloc extends Bloc<ContractorEvent, ContractorState> {
  ContractorBloc() : super(ContractorLoadingState()) {
//====================ContractorLoadEvent====================//
    on<ContractorLoadEvent>((event, emit) async {
      final contractorModelResponse = await UserRepository.getContractors();

      emit(
        ContractorLoadedState(contractorsList: contractorModelResponse.data),
      );
    });

//====================ContractorSelectedEvent====================//
    on<ContractorSelectedEvent>((event, emit) {
      emit(ContractorLoadedState(
        contractorsList: state.contractorsList,
        contractorName: event.contractorName,
      ));
    });
  }
}

final contractorBloc = ContractorBloc();
