part of 'contractor_bloc.dart';

@immutable
sealed class ContractorState {
  final List<ContractorModel>? contractorsList;
  final String? selectedContractor;
  final ContractorModel? contractor;
  final bool? contractorNotListed;
  final bool? haveNoContractor;
  const ContractorState({
    required this.contractorsList,
    required this.selectedContractor,
    required this.contractor,
    this.contractorNotListed,
    this.haveNoContractor,
  });
}

class ContractorLoadingState extends ContractorState {
  const ContractorLoadingState()
      : super(
          contractor: null,
          selectedContractor: null,
          contractorsList: null,
        );
}

class ContractorLoadedState extends ContractorState {
  const ContractorLoadedState({
    required super.contractorsList,
    required super.selectedContractor,
    required super.contractor,
    super.contractorNotListed,
    super.haveNoContractor,
  });
}

// class ContractorNotListedState extends ContractorState {
//   ContractorNotListedState()
//       : super(
//           contractor: null,
//           selectedContractor: null,
//           contractorsList: null,
//         );
// }

// class HaveNoContractorState extends ContractorState {
//   HaveNoContractorState()
//       : super(
//           contractor: DEFAULT_CONTRACTOR,
//           contractorsList: [DEFAULT_CONTRACTOR],
//           selectedContractor: DEFAULT_CONTRACTOR_STRING,
//         );
// }
