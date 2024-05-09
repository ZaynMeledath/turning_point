part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {
  final bool notification;
  const SettingsState({required this.notification});
}

final class SettingsInitial extends SettingsState {
  const SettingsInitial({required super.notification});
}

final class SettingsTriggeredState extends SettingsState {
  const SettingsTriggeredState({required super.notification});
}
