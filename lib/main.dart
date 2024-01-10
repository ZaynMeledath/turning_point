import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turning_point/auth/bloc/auth/auth_bloc.dart';
import 'package:turning_point/auth/bloc/home/home_screen_bloc.dart';
import 'package:turning_point/auth/bloc/preload/preload_bloc.dart';
import 'package:turning_point/auth/bloc/redeem/redeem_bloc.dart';
import 'package:turning_point/auth/firebase_auth_provider.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/preferences/app_preferences.dart';
import 'package:turning_point/view/home/home_screen.dart';
import 'package:turning_point/view/splash/splash_screen.dart';

final GlobalKey<NavigatorState> globalNavigatorKey =
    GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final token = AppPreferences.getValueShared('auth_token');
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
          create: (_) => HomeScreenBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Turning Point',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(0, 99, 255, 1),
          ),
          useMaterial3: true,
        ),
        home: token != null ? const HomeScreen() : const SplashScreen(),
      ),
    );
  }
}
