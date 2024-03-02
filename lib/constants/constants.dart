// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:turning_point/model/contractor_model.dart';

const placeHolderImage =
    'https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixabay.com%2Fvectors%2Favatar-icon-placeholder-facebook-1577909%2F&psig=AOvVaw0Mx14E9N2U6k_cGx6PudHg&ust=1709471976532000&source=images&cd=vfe&opi=89978449&ved=0CBMQjRxqFwoTCPCJ_MDV1YQDFQAAAAAdAAAAABAE';

final DEFAULT_CONTRACTOR = ContractorModel(
  name: 'Contractor',
  businessName: 'Turning Point',
);

final DEFAULT_CONTRACTOR_STRING =
    '${DEFAULT_CONTRACTOR.name} - ${DEFAULT_CONTRACTOR.businessName}';

const DEFAULT_REDEEM_POINTS = 500;

class TransferType {
  static const BANK = 'BANK';
  static const UPI = 'UPI';
  static const CASH = 'CASH';
  static const COUPON = 'COUPON';
}

class Role {
  static const CONTRACTOR = 'CONTRACTOR';
  static const CARPENTER = 'CARPENTER';
}
