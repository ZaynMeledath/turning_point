import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/bloc/home/home_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/preferences/app_preferences.dart';
import 'package:turning_point/utils/custom_navigator.dart';
import 'package:turning_point/view/kyc/kyc_screen.dart';

class NotificationController {
  static void navigateOnNotification(BuildContext context) {
    final notificationType = AppPreferences.getValueShared('notification_type');
    if (notificationType != null) {
      log('notificationType After: ${AppPreferences.getValueShared('notification_type')}');
      AppPreferences.removeFromPreference('notification_type');
      log('notificationType After: ${AppPreferences.getValueShared('notification_type')}');

      switch (notificationType) {
        case 'luckydraw':
          Future.delayed(Duration.zero, () {
            BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileLoadedState) {
                  if (state.isContractor) {
                    homeBloc.add(TriggerEvent(2));
                  } else {
                    homeBloc.add(TriggerEvent(3));
                  }
                }
              },
            );
          });
          break;

        case 'kyc':
          Future.delayed(Duration.zero, () {
            CustomNavigator.push(
              context: context,
              child: const KycScreen(),
            );
          });
          break;

        default:
          break;
      }
    }
  }
}
