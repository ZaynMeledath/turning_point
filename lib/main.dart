import 'dart:async';
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:turning_point/bloc/connect/connect_bloc.dart';
import 'package:turning_point/bloc/contest/contest_bloc.dart';
import 'package:turning_point/bloc/contest/join_contest_bloc.dart';
import 'package:turning_point/bloc/contractor/contractor_bloc.dart';
import 'package:turning_point/bloc/kyc/kyc_bloc.dart';
import 'package:turning_point/bloc/location_service/location_service_bloc.dart';
import 'package:turning_point/bloc/lucky_draw/lucky_draw_bloc.dart';
import 'package:turning_point/bloc/points/points_bloc.dart';
import 'package:turning_point/bloc/points_history/points_history_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/bloc/reels/reels_bloc.dart';
import 'package:turning_point/bloc/rewards/rewards_bloc.dart';
import 'package:turning_point/bloc/scanner/scanner_bloc.dart';
import 'package:turning_point/bloc/auth/auth_bloc.dart';
import 'package:turning_point/bloc/home/home_bloc.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
import 'package:turning_point/bloc/redeem/redeem_bloc.dart';
import 'package:turning_point/firebase_options.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/preferences/app_preferences.dart';
import 'package:turning_point/service/notification/awesome_notification_controller.dart';
import 'package:turning_point/view/splash/splash_screen.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final GlobalKey<NavigatorState> globalNavigatorKey =
    GlobalKey<NavigatorState>();

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onMessage.listen(_firebasePushHandler);
  FirebaseMessaging.onBackgroundMessage(_firebasePushHandler);
  AwesomeNotifications().initialize(
    'resource://drawable/notification_icon',
    [
      NotificationChannel(
        channelGroupKey: 'basic_group',
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Channel for basic notifications',
        enableVibration: true,
        importance: NotificationImportance.High,
        defaultColor: Colors.red,
      ),
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'basic_group',
        channelGroupName: 'Basic Group',
      ),
    ],
  );

  if (!await AwesomeNotifications().isNotificationAllowed()) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }

  AwesomeNotifications().setListeners(
    onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    onNotificationCreatedMethod:
        NotificationController.onNotificationCreatedMethod,
    onNotificationDisplayedMethod:
        NotificationController.onNotificationDisplayedMethod,
    onDismissActionReceivedMethod:
        NotificationController.onDismissActionReceivedMethod,
  );

//--------------------Internet Check--------------------//
  final InternetConnectionChecker customInstance =
      InternetConnectionChecker.createInstance(
    checkTimeout: const Duration(seconds: 1),
    checkInterval: const Duration(seconds: 1),
  );

  // Check internet connection with created instance
  await executeInternetChecker(customInstance);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
}

//--------------------Show toast according to the internet connection--------------------//
Future<void> executeInternetChecker(
  InternetConnectionChecker internetConnectionChecker,
) async {
  internetConnectionChecker.onStatusChange.listen(
    (InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          Fluttertoast.showToast(
            msg: "Back Online",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: screenSize.width * .036,
          );
          break;
        case InternetConnectionStatus.disconnected:
          Fluttertoast.showToast(
            msg: "No Internet Connection",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: screenSize.width * .036,
          );
          break;
      }
    },
  );
}

Future<void> _firebasePushHandler(RemoteMessage message) async {
  log('Notificatication');
  log('MESSAGE ID : ${message.messageId}');
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: DateTime.now().millisecondsSinceEpoch.remainder(1000),
      channelKey: 'basic_channel',
      title: message.notification!.title,
      body: message.notification!.body,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    getInitialScreenSize(context: context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => authBloc,
        ),
        BlocProvider(
          create: (_) => preloadBloc,
        ),
        BlocProvider(
          create: (_) => redeemBloc,
        ),
        BlocProvider(
          create: (_) => homeBloc,
        ),
        BlocProvider(
          create: (_) => contractorBloc,
        ),
        BlocProvider(
          create: (_) => reelsBloc,
        ),
        BlocProvider(
          create: (_) => pointsHistoryBloc,
        ),
        BlocProvider(
          create: (_) => profileBloc,
        ),
        BlocProvider(
          create: (_) => scannerBloc,
        ),
        BlocProvider(
          create: (_) => kycBloc,
        ),
        BlocProvider(
          create: (_) => contestBloc,
        ),
        BlocProvider(
          create: (_) => joinContestBloc,
        ),
        BlocProvider(
          create: (_) => pointsBloc,
        ),
        BlocProvider(
          create: (_) => luckyDrawBloc,
        ),
        BlocProvider(
          create: (_) => rewardsBloc,
        ),
        BlocProvider(
          create: (_) => locationServiceBloc,
        ),
        BlocProvider(
          create: (_) => connectBloc,
        ),
      ],
      child: MaterialApp(
        builder: FToastBuilder(),
        debugShowCheckedModeBanner: false,
        title: 'Turning Point',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(0, 99, 255, 1),
          ),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
