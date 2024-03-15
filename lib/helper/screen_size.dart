import 'package:flutter/material.dart';

late Size realScreenSize;
late Size screenSize;

void getInitialScreenSize({required BuildContext context}) {
  screenSize = MediaQuery.of(context).size;
  realScreenSize = screenSize;
  if (screenSize.width > 550) {
    screenSize = Size(550, screenSize.height);
  }
}
