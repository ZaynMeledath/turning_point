import 'dart:developer';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/model/contractor_model.dart';
import 'package:turning_point/resources/user_repository.dart';

part 'contractor_event.dart';
part 'contractor_state.dart';

class ContractorBloc extends Bloc<ContractorEvent, ContractorState> {
  ContractorBloc() : super(const ContractorLoadingState()) {
//====================Contractor Load Event====================//
    on<ContractorLoadEvent>((event, emit) async {
      final contractorModelResponse = await UserRepository.getContractors();
      final userModelResponse = UserRepository.getUserFromPreference();
      final contractor = userModelResponse?.data?.contractor;

      emit(
        ContractorLoadedState(
          contractorsList: contractorModelResponse.data,
          contractor: contractor,
          selectedContractor: contractor != null && contractor.name != null
              ? '${contractor.name} - ${contractor.businessName}'
              : null,
        ),
      );
    });

//====================Contractor Selected Event====================//
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

//====================Contractor Not Listed Event====================//
    on<ContractorNotListedEvent>((event, emit) {
      emit(
        ContractorLoadedState(
          contractorsList: state.contractorsList,
          selectedContractor: state.selectedContractor,
          contractor: state.contractor,
          contractorNotListed: state.contractorNotListed != null
              ? !state.contractorNotListed!
              : true,
          haveNoContractor: false,
        ),
      );
    });

//====================Have No Contractor Event====================//
    on<HaveNoContractorEvent>((event, emit) {
      emit(
        ContractorLoadedState(
          contractorsList: state.contractorsList,
          selectedContractor: state.selectedContractor,
          contractor: state.contractor,
          haveNoContractor:
              state.haveNoContractor != null ? !state.haveNoContractor! : true,
          contractorNotListed: false,
        ),
      );
    });
  }

//====================State Change Logger====================//
  @override
  void onChange(Change<ContractorState> change) {
    log('CURRENT STATE : ${change.currentState}');
    log('NEXT STATE: ${change.nextState}');
    super.onChange(change);
  }
}

final contractorBloc = ContractorBloc();
