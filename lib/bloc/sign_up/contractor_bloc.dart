import 'dart:developer';

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
        ContractorLoadedState(
          contractorsList: contractorModelResponse.data,
          contractor: null,
          contractorString: null,
        ),
      );
    });

//====================ContractorSelectedEvent====================//
    on<ContractorSelectedEvent>((event, emit) {
      final contractorDetails = event.contractorName!.split('-');
      final contractorModel = ContractorModel(
          name: contractorDetails[0], businessName: contractorDetails[1]);
      emit(
        ContractorLoadedState(
          contractorsList: state.contractorsList,
          contractorString: event.contractorName,
          contractor: contractorModel,
        ),
      );
    });
  }
  @override
  void onChange(Change<ContractorState> change) {
    log('CURRENT STATE : ${change.currentState}');
    log('NEXT STATE: ${change.nextState}');
    super.onChange(change);
  }
}

final contractorBloc = ContractorBloc();
