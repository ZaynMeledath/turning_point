part of '../lucky_draw_screen.dart';

//====================Individual Gift Container Styling====================//
Widget giftBoxContainer({String? image}) {
  return Container(
    width: screenSize.width * .24,
    height: screenSize.width * .24,
    padding: EdgeInsets.all(screenSize.width * .02),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        const BoxShadow(
          color: Color.fromRGBO(141, 149, 193, .8),
        ),
        BoxShadow(
          offset: const Offset(1, 6),
          color: const Color.fromRGBO(19, 24, 54, 1),
          spreadRadius: -screenSize.width * .028,
          blurRadius: screenSize.width * .06,
        ),
      ],
    ),
    child: image != null
        ? Image.network(image)
        : Image.asset('assets/images/red_gift_box.png'),
  );
}
