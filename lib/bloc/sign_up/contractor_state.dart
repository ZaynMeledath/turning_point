part of 'contractor_bloc.dart';

sealed class ContractorState {
  final List<ContractorModel>? contractorsList;
  final String? contractorString;
  final ContractorModel? contractor;
  ContractorState({
    required this.contractorsList,
    required this.contractorString,
    required this.contractor,
  });
}

class ContractorLoadingState extends ContractorState {
  ContractorLoadingState()
      : super(
          contractor: null,
          contractorString: null,
          contractorsList: null,
        );
}

class ContractorLoadedState extends ContractorState {
  ContractorLoadedState({
    required super.contractorsList,
    required super.contractorString,
    required super.contractor,
  });
}
