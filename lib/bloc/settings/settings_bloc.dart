import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/preferences/app_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc()
      : super(
          SettingsInitial(
            notification: AppPreferences.getValueShared('notification') ?? true,
          ),
        ) {
    on<SettingsTriggerEvent>((event, emit) {
      AppPreferences.removeFromPreference('notification');
      AppPreferences.addSharedPreference(
        key: 'notification',
        value: event.notification,
      );
      return emit(SettingsTriggeredState(notification: event.notification));
    });
  }
}

final settingsBloc = SettingsBloc();
