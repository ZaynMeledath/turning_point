import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget spinningLinesLoading({Color? color}) {
  return Center(
    child: SpinKitSpinningLines(color: color ?? Colors.amber),
  );
}

Widget rippleLoading({
  Color? color,
  double? size,
}) {
  return Center(
    child: SpinKitRipple(
      color: color ?? Colors.white,
      size: size ?? 50,
    ),
  );
}

Widget circleLoading() {
  return const Center(
    child: SpinKitFadingCircle(
      color: Colors.pink,
    ),
  );
}
