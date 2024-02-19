part of 'contractor_bloc.dart';

sealed class ContractorEvent {}

class ContractorLoadEvent extends ContractorEvent {}

class ContractorSelectedEvent extends ContractorEvent {
  final String? contractorString;
  ContractorSelectedEvent(this.contractorString);
}
