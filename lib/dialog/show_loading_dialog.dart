import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

typedef CloseDialog = void Function();

CloseDialog showLoadingDialog({
  required BuildContext context,
}) {
  const dialog = Center(child: SpinKitSpinningLines(color: Colors.white));

  showDialog(
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(.1),
    context: context,
    builder: (context) => dialog,
  );

  return () => Navigator.pop(context);
}
