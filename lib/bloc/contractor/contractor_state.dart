part of 'contractor_bloc.dart';

sealed class ContractorState {
  final List<ContractorModel>? contractorsList;
  final String? selectedContractor;
  final ContractorModel? contractor;
  ContractorState({
    required this.contractorsList,
    required this.selectedContractor,
    required this.contractor,
  });
}

class ContractorLoadingState extends ContractorState {
  ContractorLoadingState()
      : super(
          contractor: null,
          selectedContractor: null,
          contractorsList: null,
        );
}

class ContractorLoadedState extends ContractorState {
  ContractorLoadedState({
    required super.contractorsList,
    required super.selectedContractor,
    required super.contractor,
  });
}
