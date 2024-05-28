import 'package:flutter/material.dart';

class Bat extends StatelessWidget {
  final double width;
  final double height;

  const Bat({
    required this.width,
    required this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.blue[900],
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
