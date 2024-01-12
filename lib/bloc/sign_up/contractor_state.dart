part of 'contractor_bloc.dart';

sealed class ContractorState {
  final String? contractorName;
  ContractorState(this.contractorName);
}

class ContractorSelectedState extends ContractorState {
  ContractorSelectedState(super.contractorName);
}
