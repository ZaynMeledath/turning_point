part of 'contractor_bloc.dart';

sealed class ContractorEvent {}

class ContractorSelectedEvent extends ContractorEvent {
  final String? contractorName;
  ContractorSelectedEvent(this.contractorName);
}
