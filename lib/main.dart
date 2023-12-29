import 'package:flutter/material.dart';
import 'package:turning_point/helper/screen_size.dart';
import 'package:turning_point/view/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    getInitialScreenSize(context: context);
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
      home: const SplashScreen(),
    );
  }
}
