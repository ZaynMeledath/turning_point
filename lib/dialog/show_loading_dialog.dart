import 'package:flutter/material.dart';

typedef CloseDialog = void Function();

CloseDialog showLoadingDialog({
  required BuildContext context,
}) {
  const dialog = Center(
    child: CircularProgressIndicator.adaptive(),
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => dialog,
  );

  return () => Navigator.pop(context);
}
