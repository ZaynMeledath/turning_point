import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<Object?> showLoadingDialog({
  required BuildContext context,
}) async {
  const dialog = Center(child: SpinKitSpinningLines(color: Colors.white));

  return showDialog(
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(.2),
    context: context,
    builder: (context) => dialog,
  );
}
