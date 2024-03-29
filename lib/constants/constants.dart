// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:turning_point/model/contractor_model.dart';

final DEFAULT_CONTRACTOR = ContractorModel(
  name: 'Contractor',
  businessName: 'Turning Point',
);

final DEFAULT_CONTRACTOR_STRING =
    '${DEFAULT_CONTRACTOR.name} - ${DEFAULT_CONTRACTOR.businessName}';

const DEFAULT_REDEEM_POINTS = 500;

const LUCKY_DRAW_WINNER_DISPLAY_DELAY = 30;

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
