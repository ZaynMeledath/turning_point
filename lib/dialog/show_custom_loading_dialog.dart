import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<void> showCustomLoadingDialog(BuildContext context) async {
  showDialog(
    barrierColor: Colors.black.withOpacity(.2),
    barrierDismissible: false,
    context: context,
    builder: (_) => const SpinKitSpinningLines(
      color: Colors.white,
    ),
  );
}
