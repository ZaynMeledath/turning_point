part of 'contractor_bloc.dart';

sealed class ContractorEvent {}

class ContractorLoadEvent extends ContractorEvent {}

class ContractorSelectedEvent extends ContractorEvent {
  final String? selectedContractor;
  ContractorSelectedEvent(this.selectedContractor);
}

class ContractorNotListedEvent extends ContractorEvent {}

class HaveNoContractorEvent extends ContractorEvent {}
