import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:url_launcher/url_launcher.dart';

part 'connect_event.dart';
part 'connect_state.dart';

class ConnectBloc extends Bloc<ConnectEvent, ConnectState> {
  ConnectBloc() : super(ConnectInitial()) {
    on<WhatsAppConnectEvent>((event, emit) async {
      String contact = "917227906257";
      String text = 'Turning Point App Support';
      String androidUrl = "whatsapp://send?phone=$contact&text=$text";
      String iosUrl = "https://wa.me/$contact?text=${Uri.parse(text)}";

      String webUrl =
          'https://api.whatsapp.com/send/?phone=$contact&text=$text';

      try {
        if (Platform.isIOS) {
          launchUrl(Uri.parse(iosUrl));
        } else {
          launchUrl(Uri.parse(androidUrl));
        }
      } catch (e) {
        await launchUrl(Uri.parse(webUrl),
            mode: LaunchMode.externalApplication);
      }
    });

    on<PhoneConnectEvent>((event, emit) {
      launchUrl(Uri.parse('tel:+917227906257'));
    });
  }
}

final connectBloc = ConnectBloc();
