import 'package:flutter/widgets.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
import 'package:turning_point/utilities/custom_navigator.dart';
import 'package:turning_point/preferences/app_preferences.dart';
import 'package:turning_point/view/contest/contest_screen.dart';

class NotificationController {
  static void navigateOnNotification(BuildContext context) {
    final notificationType = AppPreferences.getValueShared('notification_type');
    if (notificationType != null) {
      if (notificationType == 'luckydraw') {
        AppPreferences.removeFromPreference('notification_type');
        Future.delayed(Duration.zero, () {
          if (preloadBloc.state.controllers.isNotEmpty) {
            preloadBloc.pauseCurrentController();
          }
          preloadBloc.add(ReelsScreenToggleEvent(isReelsVisible: false));
          CustomNavigator.push(
            context: context,
            child: const ContestScreen(),
          );
        });
      }
    }
  }
}
