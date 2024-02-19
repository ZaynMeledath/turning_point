import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget spinningLinesLoading() {
  return const Center(
    child: SpinKitSpinningLines(color: Colors.amber),
  );
}

Widget circleLoading() {
  return Center(
    child: SpinKitCircle(),
  );
}
