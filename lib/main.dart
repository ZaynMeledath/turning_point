import 'package:flutter/material.dart';
import 'package:turning_point/view/login_screen.dart';
// import 'package:turning_point/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Turning Point',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}



//  AnimatedSplashScreen(
//         duration: 2500,
//         splash: 'assets/images/splash_screen_logos.png',
//         splashIconSize: screenSize.height * .81,
//         nextScreen: const HomeScreen(),
//       ),