part of 'contractor_bloc.dart';

sealed class ContractorEvent {}

class ContractorLoadEvent extends ContractorEvent {
  final bool isSignUp;
  ContractorLoadEvent({required this.isSignUp});
}

class ContractorSelectedEvent extends ContractorEvent {
  final String? selectedContractor;
  ContractorSelectedEvent(this.selectedContractor);
}

class ContractorNotListedEvent extends ContractorEvent {}

class HaveNoContractorEvent extends ContractorEvent {}
