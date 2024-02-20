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
      final userModelResponse = UserRepository.getUserFromPreference();
      final contractor = userModelResponse?.data?.contractor;
      log('CONTRACTOR NAME : ${contractor?.name}');
      log('BUSINESS NAME : ${contractor?.businessName}');
      log('CONTRACTOR: ${contractor?.name} - ${contractor?.businessName}');

      emit(
        ContractorLoadedState(
          contractorsList: contractorModelResponse.data,
          contractor: contractor,
          selectedContractor: contractor != null
              ? '${contractor.name} - ${contractor.businessName}'
              : null,
        ),
      );
    });

//====================ContractorSelectedEvent====================//
    on<ContractorSelectedEvent>((event, emit) {
      final contractorDetails = event.selectedContractor!.split('-');
      final contractorModel = ContractorModel(
        name: contractorDetails[0].trim(),
        businessName: contractorDetails[1].trim(),
      );
      emit(
        ContractorLoadedState(
          contractorsList: state.contractorsList,
          selectedContractor: event.selectedContractor,
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
