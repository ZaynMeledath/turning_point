import 'package:flutter/material.dart';

Size realScreenSize = const Size(0, 0);
Size screenSize = const Size(0, 0);

void getInitialScreenSize({required BuildContext context}) {
  screenSize = MediaQuery.of(context).size;
  realScreenSize = screenSize;
  if (screenSize.width > 550) {
    screenSize = Size(550, screenSize.height);
  }
}
