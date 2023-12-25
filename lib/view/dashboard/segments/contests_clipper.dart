import 'package:flutter/material.dart';

class ContestsClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height * .35);
    path.quadraticBezierTo(
      size.width * .15,
      size.height * .5,
      0,
      size.height * .65,
    );

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * .65);
    path.quadraticBezierTo(
      size.width * .85,
      size.height * .5,
      size.width,
      size.height * .35,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
