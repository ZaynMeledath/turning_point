import 'dart:developer';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  ScannerBloc() : super(ScannerInitial()) {
    //
  }
  @override
  void onChange(Change<ScannerState> change) {
    log('CURRENT STATE : ${change.currentState}');
    log('NEXT STATE: ${change.nextState}');
    super.onChange(change);
  }
}

final scannerBloc = ScannerBloc();
