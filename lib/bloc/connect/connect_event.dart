part of 'connect_bloc.dart';

@immutable
sealed class ConnectEvent {}

class WhatsAppConnectEvent extends ConnectEvent {}

class PhoneConnectEvent extends ConnectEvent {}
