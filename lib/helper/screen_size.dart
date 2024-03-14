import 'package:flutter/material.dart';

late Size screenSize;

void getInitialScreenSize({required BuildContext context}) {
  screenSize = MediaQuery.of(context).size;
  if (screenSize.width > 600) {
    screenSize = Size(600, screenSize.height);
  }
}
