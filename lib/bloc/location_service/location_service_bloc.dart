import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:turning_point/resources/location_repository.dart';
import 'package:workmanager/workmanager.dart';

part 'location_service_event.dart';
part 'location_service_state.dart';

class LocationServiceBloc
    extends Bloc<LocationServiceEvent, LocationServiceState> {
  LocationServiceBloc() : super(LocationServiceInitial()) {
    on<LocationServiceStartEvent>((event, emit) async {
      await LocationRepository.sendLocationToServer();

      await Workmanager().initialize(
        callbackDispatcher,
        isInDebugMode: true,
      );

      await Workmanager().registerPeriodicTask(
        "1",
        fetchBackground,
        frequency: const Duration(minutes: 15),
      );

      log('LOCATION SERVICE BLOC EXECUTED');
    });
  }
}

final locationServiceBloc = LocationServiceBloc();
