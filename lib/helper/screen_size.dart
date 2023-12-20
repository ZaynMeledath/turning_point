import 'package:flutter/material.dart';

late Size screenSize;

void getInitialScreenSize({required BuildContext context}) {
  screenSize = MediaQuery.of(context).size;
}
