part of 'contractor_bloc.dart';

sealed class ContractorState {
  final List<ContractorModel>? contractorsList;
  final String? contractorName;
  ContractorState({
    this.contractorsList,
    this.contractorName,
  });
}

class ContractorLoadingState extends ContractorState {}

class ContractorLoadedState extends ContractorState {
  ContractorLoadedState({
    required super.contractorsList,
    super.contractorName,
  });
}
