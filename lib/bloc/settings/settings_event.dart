part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

class SettingsTriggerEvent extends SettingsEvent {
  final bool notification;
  SettingsTriggerEvent({required this.notification});
}
