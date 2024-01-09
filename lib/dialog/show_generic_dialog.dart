import 'package:flutter/material.dart';

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required Map<String, T?> options,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          elevation: 80,
          title: Text(title),
          content: Text(content),
          actions: options.keys.map((optionTitle) {
            final T? value = options[optionTitle];
            return TextButton(
                onPressed: () {
                  if (value != null) {
                    Navigator.of(context).pop(value);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(optionTitle));
          }).toList(),
        );
      });
}
