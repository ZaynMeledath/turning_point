import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/bloc/points_history/points_history_bloc.dart';
import 'package:turning_point/bloc/profile/profile_bloc.dart';
import 'package:turning_point/bloc/reels/reels_bloc.dart';
import 'package:turning_point/bloc/scanner/scanner_bloc.dart';
import 'package:turning_point/bloc/sign_up/contractor_bloc.dart';
import 'package:turning_point/service/auth/firebase_auth_provider.dart';
import 'package:turning_point/bloc/auth/auth_bloc.dart';
import 'package:turning_point/bloc/home/home_bloc.dart';
import 'package:turning_point/bloc/preload/preload_bloc.dart';
import 'package:turning_point/bloc/redeem/redeem_bloc.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/preferences/app_preferences.dart';
import 'package:turning_point/view/home/home_screen.dart';
import 'package:turning_point/view/splash/splash_screen.dart';

final GlobalKey<NavigatorState> globalNavigatorKey =
    GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    getInitialScreenSize(context: context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(FirebaseAuthProvider()),
        ),
        BlocProvider(
          create: (_) => PreloadBloc(),
        ),
        BlocProvider(
          create: (_) => RedeemBloc(),
        ),
        BlocProvider(
          create: (_) => HomeBloc(),
        ),
        BlocProvider(
          create: (_) => ContractorBloc(),
        ),
        BlocProvider(
          create: (_) => ReelsBloc(),
        ),
        BlocProvider(
          create: (_) => PointsHistoryBloc(),
        ),
        BlocProvider(
          create: (_) => ProfileBloc(),
        ),
        BlocProvider(
          create: (_) => ScannerBloc(),
        ),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          context.read<AuthBloc>().add(AuthInitializeEvent());
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Turning Point',
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromRGBO(0, 99, 255, 1),
              ),
              useMaterial3: true,
            ),
            home: state is SignedInState
                ? const HomeScreen()
                : const SplashScreen(),
          );
        },
      ),
    );
  }
}
