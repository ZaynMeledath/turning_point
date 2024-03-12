import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CustomNavigator {
//====================Navigator Push====================//
  static dynamic push({
    required BuildContext context,
    required Widget child,
  }) {
    return Navigator.of(context).push(
      PageTransition(
        child: child,
        type: PageTransitionType.rightToLeft,
        duration: const Duration(milliseconds: 350),
        reverseDuration: const Duration(milliseconds: 150),
      ),
    );
  }

//====================Navigator Push and Remove====================//
  static dynamic pushAndRemove({
    required BuildContext context,
    required Widget child,
  }) {
    return Navigator.of(context).pushAndRemoveUntil(
      PageTransition(
        child: child,
        type: PageTransitionType.rightToLeft,
        duration: const Duration(milliseconds: 350),
      ),
      (_) => false,
    );
  }

//====================Navigator Push Replacement====================//
  static dynamic pushReplacement({
    required BuildContext context,
    required Widget child,
  }) {
    return Navigator.of(context).push(
      PageTransition(
        child: child,
        type: PageTransitionType.rightToLeft,
        duration: const Duration(milliseconds: 350),
        reverseDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
