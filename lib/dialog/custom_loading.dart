import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget spinningLinesLoading() {
  return const Center(
    child: SpinKitSpinningLines(color: Colors.amber),
  );
}

Widget circleLoading() {
  return const Center(
    child: SpinKitFadingCircle(
      color: Colors.pink,
    ),
  );
}