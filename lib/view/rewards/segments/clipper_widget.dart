import 'package:flutter/material.dart';
import 'package:turning_point/bloc/rewards/rewards_bloc.dart';

class ClipperWidget extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height);
    if (rewardsBloc.state.isScrolled == true) {
      path.lineTo(size.width, size.height);
    } else {
      path.lineTo(size.width, size.height * .78);
    }
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
