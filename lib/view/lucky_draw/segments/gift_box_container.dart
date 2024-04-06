part of '../lucky_draw_screen.dart';

//====================Individual Gift Container Styling====================//
Widget giftBoxContainer({String? image}) {
  return Container(
    width: screenSize.width * .24,
    height: screenSize.width * .24,
    padding: EdgeInsets.all(screenSize.width * .02),
    decoration: BoxDecoration(
      color: const Color.fromRGBO(49, 55, 92, 1),
      // color: Color.fromARGB(255, 39, 45, 78),

      borderRadius: BorderRadius.circular(8),
      boxShadow: const [
        BoxShadow(
          // offset: Offset(0, 1),
          blurRadius: 1,
          // spreadRadius: 3,
          color: Color.fromRGBO(141, 149, 194, 1),
          blurStyle: BlurStyle.outer,
        ),
        // BoxShadow(
        //   offset: Offset(0, 1),
        //   blurRadius: 40,
        //   color: Color.fromRGBO(141, 149, 193, .6),
        //   blurStyle: BlurStyle.inner,
        // ),
      ],
    ),
    child: image != null
        ? Image.network(image)
        : Image.asset('assets/images/red_gift_box.png'),
  );
}
