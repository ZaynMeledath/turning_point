import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoaded = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        isLoaded = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Stack(
        alignment: Alignment.center,
        children: [],
      ),
      bottomNavigationBar: CurvedNavigationBar(items: const [
        Icon(Icons.home),
        Icon(Icons.qr_code_scanner),
        Icon(CupertinoIcons.gift),
        Icon(Icons.phone)
      ]),
    );
  }
}
