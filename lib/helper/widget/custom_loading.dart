import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget spinningLinesLoading({
  Color? color,
  double? size,
}) {
  return Center(
    child: SpinKitSpinningLines(
      color: color ?? Colors.amber,
      size: size ?? 60,
    ),
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
